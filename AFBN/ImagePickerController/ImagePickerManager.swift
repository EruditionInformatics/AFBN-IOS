import Foundation
import UIKit


class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    //var pickImageCallback : ((UIImage) -> ())?;
    var pickImageCallback : ((NSDictionary) -> ())?;
    var vid_Or_imgType: String?
    
    override init(){
        super.init()
    }
    
    //func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ()))
    func pickImage(_ viewController: UIViewController,_ type:String, _ callback: @escaping ((NSDictionary) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;
        self.vid_Or_imgType = type
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            if(self.vid_Or_imgType == "video"){
                picker.mediaTypes = UIImagePickerController.availableMediaTypes(for:.camera)!
            }
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            
            CommonClass.commonSharedInstance.show_alert(alert_title: "Warning", btn_title: "Ok", msg: "You don't have camera", presentingClass: viewController!)
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        if(self.vid_Or_imgType == "video"){
            picker.mediaTypes = ["public.movie"]
        }
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        pickImageCallback?(image)
//    }
    
    //  // For Swift 4.2
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          picker.dismiss(animated: true, completion: nil)
        if(self.vid_Or_imgType == "video"){
            guard let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
                //fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                return
            }
            print(videoURL)
            pickImageCallback?(info as NSDictionary)
        }else{
            guard let image = info[.originalImage] as? UIImage else {
                //fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                return
            }
            print(image)
            //pickImageCallback?(image)
            pickImageCallback?(info as NSDictionary)
        }
        
        
      }
    
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }
    
}
