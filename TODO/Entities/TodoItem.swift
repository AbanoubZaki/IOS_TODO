//
//  Todo.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation

struct TodoItem {
    let name: String
    let description: String
    let id: String

    init(name: String, description: String) {
        self.id = UUID().uuidString
        self.name = name
        self.description = description
    }
    
    init(name: String, description: String, id: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
