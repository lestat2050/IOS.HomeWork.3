//
//  Car.swift
//  CarСatalog
//
//  Created by Yaroslav Surovtsev on 16.07.17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import Foundation

class Car {
    
    var brand: String
    var model: String
    var releaseDate: Date
    
    init(brand: String, model: String, releaseDate: Date) {
        self.brand = brand
        self.model = model
        self.releaseDate = releaseDate
    }
    
}
