//
//  DogDatabase.swift
//  Deep Linked Dogs
//
//  Created by Clay Jones on 11/8/17.
//  Copyright © 2017 Branch Metrics. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DogDatabase: NSObject {
    
    class func getAllBreeds(completion: @escaping (_ breeds: [DogBreed]?)->()){
        Alamofire.request("https://dog.ceo/api/breeds/list/all").responseJSON { (response) in
            let jsonData = JSON(response.result.value as Any)
            let message = jsonData["message"].dictionaryObject
            var breeds = [DogBreed]()
            for breed: String in (message?.keys)! {
                let subbreeds = message?[breed] as? [String]
                breeds.append(DogBreed(name: breed, subbreeds: subbreeds))
            }
            completion(breeds)
        }
    }
    
    class func getAllDogsForBreed(breed: String, completion: @escaping (_ dogs: [Dog]?)->()){
        Alamofire.request("https://dog.ceo/api/breed/\(breed)/images").responseJSON { (response) in
            let jsonData = JSON(response.result.value as Any)
            let message = jsonData["message"].arrayObject as? [String]
            var dogs = [Dog]()
            for image: String in message! {
               let dog = Dog(imageURL: image)
                dogs.append(dog)
            }
            completion(dogs)
        }
    }
}
