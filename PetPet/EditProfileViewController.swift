//
//  EditProfileViewController.swift
//  PetPet
//
//  Created by nttr on 2018/12/28.
//  Copyright © 2018年 nttr.inc. All rights reserved.
//

import UIKit
import NCMB
import MBProgressHUD

protocol EditProfileViewControllerDelegate{
    func editDidFinished(modalText: String?)
}
class EditProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userBirthdayTextField: UITextField!
    @IBOutlet var userBloodTextField: UITextField!
    @IBOutlet var userPlaceTextField: UITextField!
    @IBOutlet var userHospitalTextField: UITextField!
    
    var delegate: EditProfileViewControllerDelegate! = nil
    
    //@IBOutlet weak var editText: UITextField!
    

    
    @IBAction func tapButton(sender: UIButton) {
        let nameText = userNameTextField.text!
        let birthdayText = userBirthdayTextField.text!
        let bloodtypeText = userBloodTextField.text!
        let placeText = userPlaceTextField.text!
        let hospitalText = userHospitalTextField.text!
        
        UserDefaults.standard.set(nameText, forKey: "NameText")
        UserDefaults.standard.set(birthdayText, forKey: "BirthdayText")
        UserDefaults.standard.set(bloodtypeText, forKey: "BloodText")
        UserDefaults.standard.set(placeText, forKey: "PlaceText")
        UserDefaults.standard.set(hospitalText, forKey: "HospitalText")
        
        
        
        UserDefaults.standard.synchronize()
        
        Profile.saveProfile(name: nameText, birthday: birthdayText, bloodtype: bloodtypeText, place: placeText, hospital: hospitalText) { (error) in
            print(error?.code)
        }
        
        sleep(1)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        userBirthdayTextField.delegate = self
        userBloodTextField.delegate = self
        userPlaceTextField.delegate = self
        userHospitalTextField.delegate = self
        
        userNameTextField.text = UserDefaults.standard.string(forKey: "NameText")
        userBirthdayTextField.text = UserDefaults.standard.string(forKey: "BirthdayText")
        userBloodTextField.text = UserDefaults.standard.string(forKey: "BloodText")
        userPlaceTextField.text = UserDefaults.standard.string(forKey: "PlaceText")
        userHospitalTextField.text = UserDefaults.standard.string(forKey: "HospitalText")
        
        //let userName = NCMBUser.current().userName
        //userNameTextField.text = userName
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as! UIImage
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        Room.upload(image: selectedImage, name: nil) { (url, error) in
            if let error = error {
                hud.hide(animated: true)
                print(error.localizedDescription)
            } else {
                hud.hide(animated: true)
                if let url = url {
                    Room.update(imageUrl: url, roomObjectId: Room.currentRoom.objectId, completion: { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.userImageView.image = selectedImage
                        }
                    })
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func selectImage() {
        let actionController = UIAlertController(title: "画像の選択", message: "選択してください", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            }
        
        let libAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)

        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            actionController.dismiss(animated: true, completion: nil)
        }
        
        // ボタンの追加
        actionController.addAction(cameraAction)
        actionController.addAction(libAction)
        actionController.addAction(cancelAction)
        
        // 表示
        self.present(actionController, animated: true, completion: nil)
    }
    

    @IBAction func closeEditViewController() {
        self.dismiss(animated: true, completion: nil)
    }

}
