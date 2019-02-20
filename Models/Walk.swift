//
//  Walk.swift
//  PetPet
//
//  Created by nttr on 2019/01/28.
//  Copyright © 2019年 nttr.inc. All rights reserved.
//


import UIKit
import NCMB

class Walk {
    
    var date: Date?
    var roomKey: String?
    var user: NCMBUser?
    
    static func saveWalk(roomKey: String, user: NCMBUser, completion: @escaping(Error?) -> ()) {
        let object = NCMBObject(className: "Walk")
        object?.setObject(roomKey, forKey: "roomKey")
        object?.setObject(user, forKey: "user")
        object?.saveInBackground({ (error) in
            completion(error)
        })
    }
    
    static func loadWalkRecords(roomKey: String, completion: @escaping([Walk]?, Error?) -> ()) {
        print(roomKey)
        let query = NCMBQuery(className: "Walk")
     //   query?.whereKey(roomKey, equalTo: "roomKey")
        query?.includeKey("user")
        query?.findObjectsInBackground({ (result, error) in
            if let error = error {
                completion(nil, error)
            } else {
                if let objects = result as? [NCMBObject] {
                    var walkRecords = [Walk]()
                    for object in objects {
                        let walkRecord = Walk()
                        walkRecord.date = object.createDate
            //            walkRecord.roomKey = object.object(forKey: "roomKey") as? String
                        walkRecord.user = object.object(forKey: "user") as? NCMBUser
                        walkRecords.append(walkRecord)
                    }
                    completion(walkRecords, nil)
                } else {
                    completion(nil, nil)
                }
            }
        })
    }
}
