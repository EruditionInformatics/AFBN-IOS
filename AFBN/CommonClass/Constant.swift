//
//  Constant.swift
//  AFBN
//
//  Created by Erudition Informatics on 26/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import Foundation

class Constant{
    
    static let constant = Constant()
    
    //var isLogedIn: Bool = false
    
    //MARK:base url
    static let BASE_URL = "http://loudeffect.ga/afbnapi/api/"
    
    let str1 = "Thank you for your interest to be part of AFBN (African Bridge Network). To maintain a high quality network, all applying freight forwarders undergo a screening process. To enable us to respond as fast and precisely as possible,we would be grateful if you would take a moment to fill the application form and send to\nmarketing@afbn-networks.com,\nsuport@afbn-networks.com,\nBen@afbn-networks.com or\nMo@afbn-networks.com\nor provide the following information and click \"submit\". We will contact you very soon! For more information or enquiries, please contact:\nmarketing@afbn-networks.com or\nsupport@afbn-networks.com,\nThis Application Form aims to gather the most pertinent information about your company,and service specialization. Upon submission, we will notify you of your application status within 5 working days."
    
    let str2 = "1. The network reserves the right not to disclose any information regarding your application.\n2. This is to confirm that I am not an owner/administrator/board member or advisor to other freight forwarding networks/alliances, profit or non-profit oriented. I agree that if any form of link is established that my membership can be cancelled without refund and agree that AFBN may terminate my attendance/members and inform all members/attendees of my termination including other network owners, associations, alliances.\n3. This is to confirm that we do not have any outstanding payables with any of our forwarding partners beyond 60 days, or any outstanding disputes. This is to confirm that we are not listed on any blacklisting either in FDRS or our local association, any findings can be published. "
    
    //MARK:XMPP Credentials
    static let XMPP_JID = UserDefaults.standard.string(forKey: "user_key")! + "@onschool.tk"//"USRPHcea422cf@vmi259536.contaboserver.net"
    static let XMPP_HOST = "onschool.tk"
    static let XMPP_PASS = UserDefaults.standard.string(forKey: "user_key")//"USRPH9d4aeb19"//"USRPHcea422cf"
    static let XMPP_GROUP_CHAT_HOST = "@conference.onschool.tk"
    
    //MARK:JITSI call type
    static let JITSI_CALL_VIDEO_TYPE = "video"
    static let JITSI_CALL_AUDIO_TYPE = "audio"
    
    static let GROUP = "false"
    
    //MARK: API URLS
    static let REGISTRATION_URL = "userregistration"
    static let SINGIN_URL = "emailUserLogin"
    static let FEEDLIST_URL = "feedlist"
    static let FEEDCREATE_URL = "feedcreate"
    static let FEED_LIKE_URL = "feedlike"
    static let FEED_COMMENT_LIST_URL = "feedcommentlist"
    static let FEED_POST_COMMENT_URL = "postcomment"
    static let MEMBER_LIST_URL = "userlist"
    static let INVITATION_LIST_URL = "requestlist"
    static let FRIEND_LIST_URL = "friendlist"
    
    static let MSGLIST_TWOUSER_URL = "phoneUserChathistory"
    static let MSGSEND_TWOUSER_URL = "phoneUserChat"
    static let CREATE_GROUP_URL = "createChatroom"
    static let SEND_CALL_NOTIFY_URL = "sendCallNotification"
    static let SEND_CALL_DISCONNECT_NOTIFY_URL = "sendCallDisconnectNotification"
    static let SEND_CALL_UP_NOTIFY_URL = "sendCallReceivedNotification"
    
}
