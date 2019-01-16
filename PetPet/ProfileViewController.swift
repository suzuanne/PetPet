//
//  ProfileViewController.swift
//  PetPet
//
//  Created by nttr on 2018/12/26.
//  Copyright © 2018年 nttr.inc. All rights reserved.
//

import UIKit
import NCMB

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    // 写真を表示するビュー
    @IBOutlet weak var imageView: UIImageView!
   
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func tapEditButton(sender: UIButton) {
        let view = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        view.delegate = self as? EditProfileViewControllerDelegate
        present(view, animated: true, completion: nil)
    }
    
    func editDidFinished(text: String?){
        textField.text = text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "default.png")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // textField.text = appDelegate.Text
        print("うわああああああああああああああああああああああああ")
        
        
    }

    // カメラロールから写真を選択する処理
    @IBAction func choosePicture() {
        // カメラロールが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }
 
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // 選択した写真を取得する
        let image = info[.originalImage] as! UIImage
        // ビューに表示する
        self.imageView.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
    
    // 写真をリセットする処理
    @IBAction func resetPicture() {
        // アラートで確認
        let alert = UIAlertController(title: "確認", message: "画像を初期化してもよいですか？", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
            // デフォルトの画像を表示する
            self.imageView.image = UIImage(named: "default.png")
        })
        let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        // アラートにボタン追加
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        // アラート表示
        present(alert, animated: true, completion: nil)
    }
}
