//
//  Food.swift
//  PetPet
//
//  Created by nttr on 2019/01/23.
//  Copyright © 2019年 nttr.inc. All rights reserved.
//

import UIKit
import NCMB

class Food {
    
    var date: Date?
    var roomKey: String?
    var user: NCMBUser?

    static func saveFood(roomKey: String, user: NCMBUser, completion: @escaping(Error?) -> ()) {
        let object = NCMBObject(className: "Food")
        object?.setObject(roomKey, forKey: "roomKey")
        object?.setObject(user, forKey: "user")
        object?.saveInBackground({ (error) in
            completion(error)
        })
    }
    
    static func loadFoodRecords(roomKey: String, completion: @escaping([Food]?, Error?) -> ()) {
        print(roomKey)
        let query = NCMBQuery(className: "Food")
        // query?.whereKey(roomKey, equalTo: "roomKey")
        query?.includeKey("user")
        query?.findObjectsInBackground({ (result, error) in
            if let error = error {
                completion(nil, error)
            } else {
                if let objects = result as? [NCMBObject] {
                    var foodRecords = [Food]()
                    for object in objects {
                        let foodRecord = Food()
                        foodRecord.date = object.createDate
                        foodRecord.roomKey = object.object(forKey: "roomKey") as? String
                        foodRecord.user = object.object(forKey: "user") as? NCMBUser
                        foodRecords.append(foodRecord)
                    }
                    completion(foodRecords, nil)
                } else {
                    completion(nil, nil)
                }
            }
        })
    }
}
