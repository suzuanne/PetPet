//
//  Profile.swift
//  PetPet
//
//  Created by nttr on 2019/01/23.
//  Copyright © 2019年 nttr.inc. All rights reserved.
//

import Foundation
import NCMB

class Profile {
    
    var name: String?
    var birthday: String?
    var bloodtype: String?
    var place: String?
    var hospital: String?
 
    static func saveProfile(name: String, birthday: String, bloodtype: String, place: String, hospital: String, completion: @escaping(Error?) -> ()) {
        let object = NCMBObject(className: "Profile")
        object?.setObject(name, forKey: "petName")
        object?.setObject(birthday, forKey: "birthday")
        object?.setObject(bloodtype, forKey: "bloodtype")
        object?.setObject(place, forKey: "place")
        object?.setObject(hospital, forKey: "hospital")
    
        object?.saveInBackground({ (error) in
            print("aaaaaa = \(error?.code)")
            completion(error)
        })
    }
    
    static func loadProfile(roomKey: String, completion: @escaping([Profile]?, Error?) -> ()) {
        print(roomKey)
        let query = NCMBQuery(className: "Profile")
        // query?.whereKey(roomKey, equalTo: "roomKey")
        query?.includeKey("petName")
        query?.findObjectsInBackground({ (result, error) in
            if let error = error {
                completion(nil, error)
            } else {
                if let objects = result as? [NCMBObject] {
                    var profileRecords = [Profile]()
                    for object in objects {
                        let profileRecord = Profile()
                        profileRecord.name = object.object(forKey: "petName") as? String
                        profileRecord.birthday = object.object(forKey: "birthday") as? String
                        profileRecord.bloodtype = object.object(forKey: "bloodtype") as? String
                        profileRecord.place = object.object(forKey: "place") as? String
                        profileRecord.hospital = object.object(forKey: "hospital") as? String
                        
                        
                        profileRecords.append(profileRecord)
                    }
                    completion(profileRecords, nil)
                } else {
                    completion(nil, nil)
                }
            }
        })
    }
}
