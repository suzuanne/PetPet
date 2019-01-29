//
//  FoodFoodViewController.swift
//  PetPet
//
//  Created by nttr on 2019/01/23.
//  Copyright © 2019年 nttr.inc. All rights reserved.
//

import UIKit
import NCMB

class FoodFoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var foodRecords :[Food] = [Food]()
    
    @IBOutlet var foodRecordTableView: UITableView!
    @IBOutlet var foodButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "FoodRecordTableViewCell", bundle: Bundle.main)
        foodRecordTableView.register(nib, forCellReuseIdentifier: "FoodRecordTableViewCell")
        
        foodRecordTableView.dataSource = self
        foodRecordTableView.estimatedRowHeight = 56.0
        //foodRecordTableView.rowHeight = UITableView.automaticDimension
        foodRecordTableView.rowHeight = 100.0
        foodRecordTableView.tableFooterView = UIView()
        
        foodButton.layer.cornerRadius = 28.0
        foodButton.layer.masksToBounds = true
        
        loadRecords()
    }
    
    func tableView(_ foodRecordTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodRecords.count
    }
    
    func tableView(_ foodRecordTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
            foodRecordTableView.dequeueReusableCell(withIdentifier: "FoodRecordTableViewCell") as! FoodRecordTableViewCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH時mm分"
        formatter.locale = Locale(identifier: "jp_JP")
        
        if let date = foodRecords[indexPath.row].date {
            let time = formatter.string(from: date)
            cell.timeLabel.text = time
        }
        
        cell.textLabel?.text = formatter.string(from: foodRecords[indexPath.row].date!)
        cell.textLabel?.textColor = UIColor(red: 235/255, green: 150/255, blue: 139/255, alpha: 1.0)
        //cell.contentView.backgroundColor = UIColor(red: 186/255, green: 87/255, blue: 114/255, alpha: 1.0)
        
        cell.userNameLabel.text = foodRecords[indexPath.row].user?.object(forKey: "displayName") as? String
        cell.userNameLabel.textColor = UIColor(red: 235/255, green: 150/255, blue: 139/255, alpha: 1.0)
        return cell
    }
    
    @available(iOS 11.0, *)
    func tableView(_ foodRecordTableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
        UISwipeActionsConfiguration? {
        let delete: UIContextualAction =
            UIContextualAction(style: .normal, title: "削除"){ (action: UIContextualAction, view: UIView,  completionHandler) in
                foodRecordTableView.deleteRows(at: [indexPath], with: .fade)
                self.foodRecords.remove(at: indexPath.row)
                completionHandler(true)
        }
                
        delete.backgroundColor = UIColor.red
        
        let deleteAction = UISwipeActionsConfiguration(actions: [delete])
        //deleteAction.performsFirstActionWithFullSwipe = false
        
        return deleteAction
    }
    
    func tableView(_ foodRecordTableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ foodRecordTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func loadRecords() {
        if let roomKey = Room.currentRoom.roomKey {
            Food.loadFoodRecords(roomKey: roomKey) { (foods, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let foods = foods {
                        self.foodRecords = foods
                        self.foodRecords.reverse()
                        self.foodRecordTableView.reloadData()
                    }
                }
            }
        } else {
            print("roomKey is nil")
        }
    }
    
    @IBAction func addRecord() {
        if let roomKey = Room.currentRoom.roomKey {
            Food.saveFood(roomKey: roomKey, user: NCMBUser.current()) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.loadRecords()
                }
            }
        }
    }

}
