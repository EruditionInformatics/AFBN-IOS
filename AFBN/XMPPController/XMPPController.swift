//
//  XMPPController.swift
//  ChatmachineApp
//
//  Created by Erudition Informatics on 24/05/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit
import XMPPFramework
import SwiftyXMLParser

protocol XMPPControllerDelegate{
    func setLastTime(sec:Int)
    func getMsg(msgTxt:String)
    func getGroupChatMsg(msgTxt:String,senderName:String)
}


class XMPPController: NSObject ,XMPPStreamDelegate,XMPPRosterDelegate,XMPPLastActivityDelegate,XMPPRoomDelegate,XMPPMUCDelegate{
    
    
    
    static let XMPPControllerSharedInstance = XMPPController()
    
    var xmppControllerDelegate:XMPPControllerDelegate?
    
    var stream:XMPPStream!
    var xmppRoster: XMPPRoster!
    var xmppRosterStorage : XMPPRosterCoreDataStorage!
    var xmppReconnect :XMPPReconnect!
    
    var xmppLastActivity: XMPPLastActivity!
    
    var xmppvCardStorage: XMPPvCardCoreDataStorage!
    var xmppvCardTempModule: XMPPvCardTempModule!
    public var xmppvCardAvatarModule: XMPPvCardAvatarModule!
    var xmppCapabilitiesStorage: XMPPCapabilitiesCoreDataStorage!
    var xmppMessageDeliveryRecipts: XMPPMessageDeliveryReceipts!
    var xmppCapabilities: XMPPCapabilities!
    var user : XMPPUserCoreDataStorageObject!
    
    var xmppMessageArchivingStorage: XMPPMessageArchivingCoreDataStorage!
    var xmppMessageArchivingModule: XMPPMessageArchiving!
    
    var xmppAutoPing: XMPPAutoPing!
    
    var xmppRoom : XMPPRoom!
    var xmppIqResources :String!
    var xmppMUC : XMPPMUC!
    var groupChatUserName : String!
    
    var isGroupChat:Bool!
    
    var lastTimeCheckingUserKey:String!
    
    //MARK: XMPP connect method
    func reconnect (userKey:String){
        
        self.isGroupChat = false
        
        let JID = userKey + "@" + Constant.XMPP_HOST
        //print("userKey",userKey)
        let idArr = JID.components(separatedBy: "@")
        lastTimeCheckingUserKey = idArr[0]
        
        
        
        
        xmppLastActivity = XMPPLastActivity.init(dispatchQueue: DispatchQueue.main)
        xmppLastActivity.addDelegate(self, delegateQueue: DispatchQueue.main)
        xmppLastActivity.activate(stream)
        
        xmppLastActivity.sendQuery(to: XMPPJID(string: JID))
        
        
        
        
        
    }
    func connect() {
        
        stream = XMPPStream()
        stream.addDelegate(self, delegateQueue: DispatchQueue.main)
        
        if(xmppRosterStorage == nil){
            xmppRosterStorage = XMPPRosterCoreDataStorage()
        }
        
        xmppRoster = XMPPRoster(rosterStorage: xmppRosterStorage)
        xmppRoster.addDelegate(self, delegateQueue: DispatchQueue.main)
        xmppRoster.addUser(XMPPJID(string: Constant.XMPP_JID)!, withNickname: nil, groups: nil, subscribeToPresence: true)
        xmppRoster.autoFetchRoster = true
        xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = true
        
        stream.myJID = XMPPJID.init(string: Constant.XMPP_JID)
        stream.hostName = Constant.XMPP_HOST
        stream.hostPort = 5222
        //stream.keepAliveInterval = 0.5;
        //stream.startTLSPolicy = .required
        
        xmppLastActivity = XMPPLastActivity() //.init(dispatchQueue: DispatchQueue.main)
        xmppLastActivity.addDelegate(self, delegateQueue: DispatchQueue.main)
        xmppLastActivity.activate(stream)
        
        xmppLastActivity.sendQuery(to: XMPPJID(string: Constant.XMPP_JID))
        
        //Autoping
        xmppAutoPing = XMPPAutoPing(dispatchQueue: DispatchQueue.main)
        xmppAutoPing.activate(stream)
        xmppAutoPing.addDelegate(self, delegateQueue: DispatchQueue.main)
        xmppAutoPing.pingInterval = 2
        xmppAutoPing.pingTimeout = 2
        
        // Reconnect
        self.xmppReconnect = XMPPReconnect()
        
        self.xmppvCardStorage = XMPPvCardCoreDataStorage.sharedInstance()
        self.xmppvCardTempModule = XMPPvCardTempModule(vCardStorage: xmppvCardStorage)
        self.xmppvCardAvatarModule = XMPPvCardAvatarModule(vCardTempModule: xmppvCardTempModule)
        
        self.xmppCapabilitiesStorage = XMPPCapabilitiesCoreDataStorage.sharedInstance()
        self.xmppCapabilities = XMPPCapabilities(capabilitiesStorage: xmppCapabilitiesStorage)
        
        /*self.xmppMessageArchivingStorage = XMPPMessageArchivingCoreDataStorage.sharedInstance()
        self.xmppMessageArchivingModule = XMPPMessageArchiving(messageArchivingStorage: xmppMessageArchivingStorage)
        self.xmppMessageArchivingModule.clientSideMessageArchivingOnly = false
        
        self.xmppMessageArchivingModule.activate(stream)
        self.xmppMessageArchivingModule.addDelegate(self, delegateQueue: DispatchQueue.main)*/
        
        //Activate xmpp modules
        self.xmppReconnect.activate(stream)
        self.xmppRoster.activate(stream)
        self.xmppvCardTempModule.activate(stream)
        self.xmppvCardAvatarModule.activate(stream)
        self.xmppCapabilities.activate(stream)
        
        //xmppRoster.activate(stream)
        
        do {
            try stream.connect(withTimeout: XMPPStreamTimeoutNone)
        } catch {
            print("error connecting")
        }
    }
    
    func disconnect(){
        
        //stream.removeDelegate(delegateClass, delegateQueue: DispatchQueue.main)
        //xmppRoster.removeDelegate(delegateClass, delegateQueue: DispatchQueue.main)
        stream.disconnect()
        //stream = nil
        //xmppRoster = nil
        //xmppRosterStorage = nil
        
    }
    
    func setChatRoomForGroup(groupID:String, userName:String){
        
        self.isGroupChat = true
        
        self.groupChatUserName = userName
        print("groupChatUserName,groupID",groupChatUserName!,groupID)
        
        let JID = groupID + Constant.XMPP_GROUP_CHAT_HOST
        let roomMemoryStorage = XMPPRoomCoreDataStorage.sharedInstance()
        //XMPPRoomMemoryStorage()//XMPPRoomHybridStorage.sharedInstance()
        let roomJID = XMPPJID(string: JID)
        
        
        xmppRoom = XMPPRoom.init(roomStorage: roomMemoryStorage!, jid: roomJID!, dispatchQueue: DispatchQueue.main)
        xmppRoom.activate(stream)
        xmppRoom.addDelegate(self, delegateQueue: DispatchQueue.main)
        
        if(!xmppRoom.isJoined){
            xmppRoom.join(usingNickname: (stream.myJID?.user)!, history: nil, password: nil)
        }
        
        //let precense = XMPPPresence.init(type: nil, to: roomJID!)
        //stream.send(precense)
        
        print("xmppRoom.isJoined",xmppRoom.isJoined)
        
    }
    
    func oneToOneChatSendMsg(senderJID:String,message:String){
        
        let msg = XMPPMessage(type: "chat", to: XMPPJID(string: senderJID))
        msg.addBody(message)
        self.stream.send(msg)
        
    }
    
    func groupChatSendMsg(groupID:String,message:String){
        
        //let JID = groupID.lowercased() + Constant.XMPP_GROUP_CHAT_HOST
        
        let roomJID = XMPPJID(string: groupID)
        
        let msg = XMPPMessage(type: "groupchat", to: roomJID)
        msg.addSubject(self.groupChatUserName)
        msg.addBody(message)
        //"groupChatUserName::",groupChatUserName!)
        //xmppRoom.sendMessage(withBody: message)
        xmppRoom.send(msg)
        
    }
    
    //MARK: XMPP Delegates Method
    @objc func xmppStream(_ sender: XMPPStream, socketDidConnect socket: GCDAsyncSocket) {
        print("socketDidConnect:")
        //sender.enableBackgroundingOnSocket = true
    }
    
    @objc func xmppStreamDidStartNegotiation(_ sender: XMPPStream) {
        print("xmppStreamDidStartNegotiation:")
    }
    
    @objc private func xmppRoster(sender: XMPPRoster!, didReceiveRosterItem item: DDXMLElement!) {
        print("Did receive Roster item")
    }
    
    @objc func xmppRosterDidEndPopulating(_ sender: XMPPRoster) {
        /*if let jids = XMPPController.XMPPControllerSharedInstance.xmppRoster.xmppRosterStorage.jids(for: XMPPController.XMPPControllerSharedInstance.stream) as? [XMPPJID] {
            //print("JIDS: \(String(describing: jids))")
            for item in jids {
                print(item.user as Any)
            }
        }*/
    }
    
    @objc func xmppStream(_ sender: XMPPStream, didReceive iq: XMPPIQ) -> Bool {
        let striq = String(describing: iq.toStr!)
        let msgArr = striq.components(separatedBy: "/")
        xmppIqResources = msgArr[1]
        //print("iq ::",iq,striq)
        if iq.isResultIQ {
            //print("iq.from?.user as Any",iq.from?.user as Any)
            //print("iq.lastActivitySeconds()::iq.childElement",iq.lastActivitySeconds(),iq.childElement as Any)
            if iq.lastActivitySeconds() == 0{
                //print("lastActivitySeconds user is online")
            }else{
                //print("lastActivitySeconds user is offline")
            }
        }
        
        return false
    }
    @objc func xmppStreamWillConnect(_ sender: XMPPStream) {
        print("will connect")
    }
    
    @objc func xmppStreamConnectDidTimeout(_ sender: XMPPStream) {
        print("timeout:")
    }
    
    @objc func xmppStreamDidConnect(_ sender: XMPPStream) {
        print("connected!")
        do {
            try sender.authenticate(withPassword: Constant.XMPP_PASS!)
        } catch {
            print("error registering")
        }
    }
    
    
    @objc func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("auth done")
        sender.send(XMPPPresence())
    }
    
    
    @objc func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        print("dint not auth")
        print(error as Any)
    }
    
    @objc func xmppStream(_ sender: XMPPStream, didReceive message: XMPPMessage) {
        print(message.xmlString)
        print(message.from!)
        if(self.isGroupChat == false){
            
            let idStr = String(describing: message.from!)
            let idArr = idStr.components(separatedBy: "@")
            if(self.lastTimeCheckingUserKey == idArr[0]){
                
                let xml = try! XML.parse(message.xmlString)
                
                if let text = xml["message", "body"].text {
                    //print(text)
                    xmppControllerDelegate?.getMsg(msgTxt: text)
                    
                }
                
            }
            
        }
        
    }
    
    
    @objc func xmppStream(_ sender: XMPPStream, didReceive presence: XMPPPresence){
        //print("presence",presence.idleSince as Any,presence.presenceType as Any,presence.show as Any,presence.showType as Any,presence.showValue,presence.nick as Any,presence.status as Any)
        let presenceType = presence.type
        let myUsername = sender.myJID?.user
        
        //print("myusername \(String(describing: myUsername))")
        //print("didReceive presenceType :- ",presenceType!)
        
        if let usr = presence.from?.user {
            
            //print("didReceive presenceType :- ",presenceType!)
            //print("didReceive usr :- \(usr)")
            
            if usr == lastTimeCheckingUserKey{
                //print("lastTimeCheckingUserKey presenceType :- ",presenceType!)
                if presenceType! == "available"{
                    self.xmppControllerDelegate?.setLastTime(sec: 0)
                }else{
                    self.reconnect(userKey: lastTimeCheckingUserKey)
                }
                
            }
            
            if usr != myUsername {
                if presenceType == "available" {
                    //let dict: NSDictionary = ["presenceType":"1","user_id":usr]
                    
                    //print("presenceType ::",presenceType!)
                } else {
                    //print("presenceType ::",presenceType!)
                }
                //NotificationCenter.default.post(name: Notification.Name("ReceivedUserStatus"), object: nil)
            }
        }
    }
    
    
    @objc func numberOfIdleTimeSeconds(for sender: XMPPLastActivity, queryIQ iq: XMPPIQ, currentIdleTimeSeconds idleSeconds: UInt) -> UInt {
        //print("currentIdleTimeSeconds",idleSeconds)
        return idleSeconds
    }
    
    @objc func xmppLastActivity(_ sender: XMPPLastActivity, didReceiveResponse response: XMPPIQ) {
        let time : Int = Int(response.lastActivitySeconds())
        //print("time in seconds \(time)")
        //print("response \(String(describing: response)))")
        self.xmppControllerDelegate?.setLastTime(sec: time)
    }
    
    @objc func xmppLastActivity(_ sender: XMPPLastActivity, didNotReceiveResponse queryID: String, dueToTimeout timeout: TimeInterval) {
        print("didNotReceiveResponse",queryID)
    }
    
    /*func numberOfIdleTimeSeconds(for sender: XMPPLastActivity!, queryIQ iq: XMPPIQ!, currentIdleTimeSeconds idleSeconds: UInt) -> UInt {
        print("currentIdleTimeSeconds",idleSeconds)
        return idleSeconds
    }
    
    func xmppLastActivity(_ sender: XMPPLastActivity!, didReceiveResponse response: XMPPIQ!) {
        let time = response.lastActivitySeconds()
        print("time in seconds \(time)")
        print("response \(String(describing: response)))")
    }
    
    func xmppLastActivity(_ sender: XMPPLastActivity!, didNotReceiveResponse queryID: String!, dueToTimeout timeout: TimeInterval) {
        print("didNotReceiveResponse")
    }*/
    
    //MARK:Delegate method for chat room
    
    // MUCRoomDelegate
    @objc func xmppRoomDidCreate(_ sender: XMPPRoom) {
        print("xmppRoomDidCreate")
        
        // I prefer configure right after created
        sender.fetchConfigurationForm()
    }
    
    @objc func xmppRoomDidJoin(_ sender: XMPPRoom) {
        print("xmppRoomDidJoin")
        print("xmppRoom.isJoined",xmppRoom.isJoined)
    }
    
    @objc func xmppRoom(_ sender: XMPPRoom, didFetchConfigurationForm configForm: DDXMLElement) {
        print("didFetchConfigurationForm")
        
        let newForm = configForm.copy() as! DDXMLElement
        
        for field in newForm.elements(forName: "field") {
            
            if let _var = field.attributeStringValue(forName: "var") {
                
                switch _var {
                case "muc#roomconfig_persistentroom":
                    field.remove(forName: "value")
                    field.addChild(DDXMLElement(name: "value", numberValue: 1))
                    
                case "muc#roomconfig_membersonly":
                    field.remove(forName: "value")
                    field.addChild(DDXMLElement(name: "value", numberValue: 1))
                    
                // other configures
                default:
                    break
                }
                
            }
            
        }
        
        sender.configureRoom(usingOptions: newForm)
    }
    
    @objc func xmppRoom(_ sender: XMPPRoom, didConfigure iqResult: XMPPIQ) {
        print("didConfigure")
    }
    
    @objc func xmppRoom(_ sender:XMPPRoom , didReceive message:XMPPMessage , fromOccupant:XMPPJID){
        //print("message",message.xmlString)
        if(self.isGroupChat == true){
            
            let xml = try! XML.parse(message.xmlString)
            if let nameTxt = xml["message","subject"].text, let text = xml["message", "body"].text{
                
                //print(nameTxt,text)
                xmppControllerDelegate?.getGroupChatMsg(msgTxt: text, senderName: nameTxt)
                
            }
            
        }
        
    }
    
    
}
