//
//  AddNewCarDelegate.swift
//  CarСatalog
//
//  Created by Yaroslav Surovtsev on 11.07.17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import Foundation

protocol AddNewCarDelegate: class {
    func onCreatedNew(car: Car) -> Void
    func refreshList() -> Void
}
