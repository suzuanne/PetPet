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
    
    @IBOutlet var labelClock: UILabel!
    @IBOutlet var labelDate: UILabel!
    var displayTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelClock.text = "まだあげていないようです"
        labelDate.text = getToday(format:"yyyy-MM-dd")
        loadData()
    }
    
    func getToday(format:String = "yyyy/MM/dd HH:mm:ss") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    // 現在時刻を表示する処理
    @IBAction func displayClock() {
        // 現在時刻を「HH:MM:SS」形式で取得する
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        var displayTime = formatter.string(from: Date())    // Date()だけで現在時刻を表す
        
        // 0から始まる時刻の場合は「 H:MM:SS」形式にする
        if displayTime.hasPrefix("0") {
            // 最初に見つかった0だけ削除(スペース埋め)される
            if let range = displayTime.range(of: "0") {
                displayTime.replaceSubrange(range, with: " ")
            }
        }
        
        // ラベルに表示
        labelClock.text = displayTime
        
    }
    
    
    @IBAction func save(){
        let object = NCMBObject(className: "food")
        
        object?.setObject(labelClock.text, forKey: "text")
        object?.saveInBackground({ (error) in
            if error != nil {
                print("error")
            }else {
                print("success")
                self.loadData()
            }
        })
    }
    
    func loadData(){
        let query = NCMBQuery(className: "food")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print("error")
                self.labelClock.text = "ネットワークエラーです。"
            } else {
                let messages = result as! [NCMBObject]
                let text = messages.last?.object(forKey: "text") as! String
                
                self.labelClock.text = text
            }
        })
    }
    
    
}



