//
//  FoodViewController.swift
//  PetPet
//
//  Created by nttr on 2018/12/12.
//  Copyright © 2018年 nttr.inc. All rights reserved.
//

import UIKit
import NCMB

class FoodViewController: UIViewController {
    
    @IBOutlet var labelToday: UILabel!
    @IBOutlet var morningButton: UIButton!
    @IBOutlet var nightButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelToday.text = getToday(format:"yyyy-MM-dd")
        //loadData()
        
        morningButton.backgroundColor = UIColor(red: 226/255, green: 222/255, blue: 224/255, alpha: 1.0)                                               // 背景色
        morningButton.layer.borderWidth = 0.5                                              // 枠線の幅
        morningButton.layer.borderColor = UIColor.black.cgColor                            // 枠線の色
        morningButton.layer.cornerRadius = 8.0                                             // 角丸のサイズ
        morningButton.setTitleColor(UIColor.white, for: UIControl.State.normal)             // タイトルの色
        
        morningButton.setTitleColor(UIColor.black, for: .highlighted)
        //タップされた時のボタンの文字の色を決める
        // morningButton.setBackgroundColor(UIColor.white, for: .highlighted)
        
        nightButton.backgroundColor = UIColor(red: 226/255, green: 222/255, blue: 224/255, alpha: 1.0)
        nightButton.layer.borderWidth = 0.5
        nightButton.layer.borderColor = UIColor.black.cgColor
        nightButton.layer.cornerRadius = 8.0
        nightButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        nightButton.setTitleColor(UIColor.black, for: .highlighted)
        

    }
    
    func getToday(format:String = "yyyy年MM月dd日") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    
    @IBAction func changeMColor(){
        if (morningButton.backgroundColor == UIColor(red: 226/255, green: 222/255, blue: 224/255, alpha: 1.0)) {
        morningButton.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 168/255, alpha: 1.0)
        morningButton.layer.borderColor = UIColor.white.cgColor
            
        }else{
            morningButton.backgroundColor = UIColor(red: 226/255, green: 222/255, blue: 224/255, alpha: 1.0)
            
        }
    }
    
    @IBAction func changeNColor(){
        
        if (nightButton.backgroundColor == UIColor(red: 226/255, green: 222/255, blue: 224/255, alpha: 1.0)) {
            nightButton.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 168/255, alpha: 1.0)
            nightButton.layer.borderColor = UIColor.white.cgColor
            
        }else{
            nightButton.backgroundColor = UIColor(red: 226/255, green: 222/255, blue: 224/255, alpha: 1.0)
            
        }
    }

    


    @IBAction func clearColor(){
        morningButton.backgroundColor = UIColor(red: 226/255, green: 222/255, blue: 224/255, alpha: 1.0)
        morningButton.layer.borderColor = UIColor.black.cgColor
    }
    
}
