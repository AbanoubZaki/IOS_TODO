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
    let id: UUID

    init(name: String, description: String) {
        self.id = UUID()
        self.name = name
        self.description = description
    }
}
