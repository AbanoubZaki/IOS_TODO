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
    
    @IBOutlet weak var todoNameTextField: UITextField?
    
    @IBOutlet weak var todoDescriptionTextView: UITextView?
    
    @IBAction func saveChangesButton(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTodoDetails(todo: self.todo!)
        self.todoDescriptionTextView?.becomeFirstResponder()
    }
    
    func setTodoDetails(todo: TodoItem) {
        self.todoNameTextField?.text = todo.name
        self.todoDescriptionTextView?.text = todo.description
    }
}
