//
//  Category.swift
//  Todoey
//
//  Created by Mark Tiddy on 10/01/2019.
//  Copyright © 2019 Mark Richard Tiddy. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
