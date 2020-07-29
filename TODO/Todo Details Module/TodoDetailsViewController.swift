//
//  TodoDetailsViewController.swift
//  TODO
//
//  Created by Blink22 on 7/29/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
import UIKit

class TodoDetailsViewController: UITableViewController {
    
    var todo: TodoItem?
    
    @IBOutlet weak var todoNameLabel: UILabel?
    @IBOutlet weak var todoDescriptionLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels(todo: self.todo!)
    }

    func setLabels(todo: TodoItem) {
        self.todoNameLabel?.text = todo.name
        self.todoDescriptionLabel?.text = todo.description
    }
    
}
