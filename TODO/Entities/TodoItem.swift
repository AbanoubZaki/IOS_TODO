//
//  Todo.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation

struct TodoItem {
    var name: String
    var description: String
    var checked: Bool
    var id: String

    init(name: String, description: String) {
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.checked = false
    }
    
    init(name: String, description: String, id: String, checked: Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.checked = checked
    }
}
