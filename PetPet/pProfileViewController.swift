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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let name = UserDefaults.standard.string(forKey: "NameText")
        PetNameLabel.text = name
        
        let birthday = UserDefaults.standard.string(forKey: "BirthdayText")
        BirthdayLabel.text = birthday
        
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
            }
        })
    }
    
}
