//
//  pProfileViewController.swift
//  PetPet
//
//  Created by nttr on 2018/12/28.
//  Copyright © 2018年 nttr.inc. All rights reserved.
//

import UIKit
import NCMB
import SDWebImage

class pProfileViewController: UIViewController {
    
    @IBOutlet var petImageView: UIImageView!
    @IBOutlet var PetNameLabel: UILabel!
    @IBOutlet var BirthdayLabel: UILabel!
    @IBOutlet var BloodtypeLabel: UILabel!
    @IBOutlet var PlaceLabel: UILabel!
    @IBOutlet var HospitalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PetNameLabel.layer.borderWidth = 0.5                                              // 枠線の幅
        //PetNameLabel.layer.borderColor = UIColor.black.cgColor                            // 枠線の色
        //PetNameLabel.layer.cornerRadius = 8.0
        
        
       // BirthdayLabel.layer.borderWidth = 0.5                                              // 枠線の幅
       // BirthdayLabel.layer.borderColor = UIColor.black.cgColor                            // 枠線の色
       // BirthdayLabel.layer.cornerRadius = 8.0
        
        petImageView.layer.cornerRadius = petImageView.bounds.width / 2.0
        petImageView.layer.borderWidth = 4.0
        petImageView.layer.borderColor = UIColor.white.cgColor
        petImageView.layer.masksToBounds = true
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let roomKey = Room.currentRoom.roomKey {
            Profile.loadProfile(roomKey: roomKey) { (profiles, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    
                    if let profiles = profiles, profiles.count > 0, let dog = profiles.last {
                        self.PetNameLabel.text = dog.name
                        self.BirthdayLabel.text = dog.birthday
                        self.BloodtypeLabel.text = dog.bloodtype
                        self.PlaceLabel.text = dog.place
                        self.HospitalLabel.text = dog.hospital
                       
                    }
                }
            }
        } else {
            print("roomKey is nil")
        }
        
        loadData()
    }
    
    func loadData() {
        let query = NCMBQuery(className: "Room")
        query?.getObjectInBackground(withId: Room.currentRoom.objectId, block: { (object, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let imageUrl = object?.object(forKey: "petImageUrl") as? String
                if let imageUrl = imageUrl {
                    self.petImageView.sd_setImage(with: URL(string: imageUrl), completed: { (image, error, cache, url) in
                        
                    })
                }
                
                //let Place = object?.object(forKey: "place") as? String
                //if let Place =  Place {
                
                
                
                
                //}
            }
            
            
        }
        
        
        
    )}
    
}
