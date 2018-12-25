//
//  LoginViewController.swift
//  PetPet
//
//  Created by nttr on 2018/12/20.
//  Copyright © 2018年 nttr.inc. All rights reserved.
//

import UIKit
import NCMB

class LoginViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        NCMBUser.logInWithUsername(inBackground: uuid, password: uuid) { (user, login_error) in //★1
            if login_error != nil {
                // ログイン失敗時の処理
                let login_err : NSError = login_error as! NSError
                print("ログインに失敗しました。エラーコード：\(login_err.code)")
                // 初回利用（ユーザー未登録）の場合
                if login_err.code == 401002 { // 401002：ID/Pass認証エラー ★2
                    /* ★3 */
                    /* mBaaSユーザー登録 */
                    let new_user = NCMBUser()
                    new_user.userName = uuid
                    new_user.password = uuid
                    new_user.signUpInBackground({ (signUp_error) in
                        if signUp_error != nil {
                            // ユーザー登録失敗時の処理
                            
                        } else {
                            // ユーザー登録成功時の処理
                            
                        }
                    })
                }
                
            } else {
                // ログイン成功時の処理
                
            }
        }
    }
  

    }
    


  

