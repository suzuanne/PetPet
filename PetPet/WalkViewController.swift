//
//  WalkViewController.swift
//  PetPet
//
//  Created by nttr on 2018/12/12.
//  Copyright © 2018年 nttr.inc. All rights reserved.
//


import UIKit
import NCMB

class WalkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var walkRecords :[Walk] = [Walk]()
    
    @IBOutlet var walkRecordTableView: UITableView!
    @IBOutlet var walkButton: UIButton!
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "WalkRecordTableViewCell", bundle: Bundle.main)
        walkRecordTableView.register(nib, forCellReuseIdentifier: "WalkRecordTableViewCell")
        
        walkRecordTableView.dataSource = self
        walkRecordTableView.estimatedRowHeight = 56.0
        //walkRecordTableView.rowHeight = UITableView.automaticDimension
        walkRecordTableView.rowHeight = 100.0
        walkRecordTableView.tableFooterView = UIView()
        
        walkButton.layer.cornerRadius = 28.0
        walkButton.layer.masksToBounds = true
        
        loadRecords()
    }
    
    func tableView(_ walkRecordTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walkRecords.count
    }
    
    func tableView(_ walkRecordTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
            walkRecordTableView.dequeueReusableCell(withIdentifier: "WalkRecordTableViewCell") as! WalkRecordTableViewCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH時mm分"
        formatter.locale = Locale(identifier: "jp_JP")
        
        if let date = walkRecords[indexPath.row].date {
            let time = formatter.string(from: date)
            cell.timeLabel.text = time
        }
        
        cell.textLabel?.text = formatter.string(from: walkRecords[indexPath.row].date!)
        cell.textLabel?.textColor = UIColor(red: 235/255, green: 150/255, blue: 139/255, alpha: 1.0)
        //cell.contentView.backgroundColor = UIColor(red: 186/255, green: 87/255, blue: 114/255, alpha: 1.0)
        
        cell.userNameLabel.text = walkRecords[indexPath.row].user?.object(forKey: "displayName") as? String
        cell.userNameLabel.textColor = UIColor(red: 235/255, green: 150/255, blue: 139/255, alpha: 1.0)
        return cell
    }
    
    @available(iOS 11.0, *)
    func tableView(_ walkRecordTableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
        UISwipeActionsConfiguration? {
            let delete: UIContextualAction =
                UIContextualAction(style: .normal, title: "削除"){ (action: UIContextualAction, view: UIView,  completionHandler) in
                    walkRecordTableView.deleteRows(at: [indexPath], with: .fade)
                    self.walkRecords.remove(at: indexPath.row)
                    completionHandler(true)
            }
            
            delete.backgroundColor = UIColor.red
            
            let deleteAction = UISwipeActionsConfiguration(actions: [delete])
            //deleteAction.performsFirstActionWithFullSwipe = false
            
            return deleteAction
    }
    
    func tableView(_ walkRecordTableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ walkRecordTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func loadRecords() {
        if let roomKey = Room.currentRoom.roomKey {
            Walk.loadWalkRecords(roomKey: roomKey) { (walks, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let walks = walks {
                        self.walkRecords = walks
                        self.walkRecords.reverse()
                        self.walkRecordTableView.reloadData()
                    }
                }
            }
        } else {
            print("roomKey is nil")
        }
    }
    
    @IBAction func addRecord() {
        if let roomKey = Room.currentRoom.roomKey {
            Walk.saveWalk(roomKey: roomKey, user: NCMBUser.current()) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.loadRecords()
                }
            }
        }
    }
    
}
