//
//  Album.swift
//  PetPet
//
//  Created by nttr on 2019/01/29.
//  Copyright © 2019年 nttr.inc. All rights reserved.
//

import UIKit
import NCMB

class Album: NSObject {

    static func upload(image: UIImage, name: String?, completion: @escaping(String?, Error?) -> ()) {
        let data = image.pngData()
        if let name = name {
            let file = NCMBFile.file(withName: name, data: data) as! NCMBFile
            file.saveInBackground({ (error) in
                let path = "https://mbaas.api.nifcloud.com/2013-09-01/applications/rm0AEmzYsi774DpU/publicFiles/" + name
                completion(path, error)
            }) { (progress) in
                print(progress)
            }
        } else {
            let file = NCMBFile.file(with: data) as! NCMBFile
            file.saveInBackground({ (error) in
                let path = "https://mbaas.api.nifcloud.com/2013-09-01/applications/rm0AEmzYsi774DpU/publicFiles/" + file.name
                completion(path, error)
            }) { (progress) in
                print(progress)
            }
        }
    }
}
