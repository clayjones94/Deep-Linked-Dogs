//
//  DogBreed.swift
//  Deep Linked Dogs
//
//  Created by Clay Jones on 11/8/17.
//  Copyright © 2017 Branch Metrics. All rights reserved.
//

import UIKit

class DogBreed {
    var name: String!
    var subbreeds: [String]?
    
    init(name: String, subbreeds: [String]?) {
        self.name = name
        self.subbreeds = subbreeds
    }
}
