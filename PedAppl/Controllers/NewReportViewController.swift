//
//  NewReportViewController.swift
//  UI
//
//  Created by lokesh madugam on 25/09/22.
//

import UIKit
import MessageUI
import CoreData

class NewReportViewController: UIViewController, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var addressTxtFld: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var titleTxtFld: UITextField!
    
    var imagePicker = UIImagePickerController()
    let mail = MFMailComposeViewController()
    var imageData : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        self.view.addGestureRecognizer(viewTap)
        
    }
    
    @objc func hideKeyBoard() {
        self.addressTxtFld.resignFirstResponder()
        self.descriptionTxtView.resignFirstResponder()
        self.titleTxtFld.resignFirstResponder()
    }

    @IBAction func onTappedCancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onTappedCameraBtn(_ sender: Any) {
        imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true)
    }
    
    @IBAction func onTappedAttachedphotoBtn(_ sender: Any) {
        imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    @IBAction func onTappedReportIssueBtn(_ sender: Any) {
        print("btn tapped")
        if MFMailComposeViewController.canSendMail() {
              
              mail.mailComposeDelegate = self;
              mail.setCcRecipients(["yyyy@xxx.com"])
              mail.setSubject("Your messagge")
              mail.setMessageBody("Message body", isHTML: false)
            if let _ = imageData {
            let imageData: NSData = imageData!.pngData()! as NSData
            mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
            }
            self.present(mail, animated: true, completion: nil)
            }
    }
}


extension NewReportViewController : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageData = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        print(imageData)

        picker.dismiss(animated: true)
    }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        picker.dismiss(animated: true)
    }
}

extension NewReportViewController : MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        print("finished mail")
        mail.dismiss(animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            save()
            print("cancelled")
        case .saved:
            save()
            print("saved")
        case .sent:
            save()
        case .failed:
            save()
            print("failed")
        }
        mail.dismiss(animated: true)
    }
    
    func save() {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Report",
                                   in: managedContext)!
      
      let report = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      report.setValue("Pot holes", forKeyPath: "title")
        report.setValue("Too many holes, its like road on holes", forKeyPath: "desc")
        report.setValue("Austin, Texas", forKeyPath: "location")
      
      // 4
      do {
        try managedContext.save()
//        people.append(person)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
}
