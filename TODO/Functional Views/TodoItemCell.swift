//
//  TodoItemCell.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
import UIKit

class TodoItemCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var todo: TodoItem? {
      didSet {
        guard let todo = todo else { return }
        nameLabel.text = todo.name
        descriptionLabel.text = todo.description
        if todo.checked {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
      }
    }
}
