//
//  NewTodoViewController.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit

class NewTodoViewController: UITableViewController {
    
    var todo: TodoItem?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "SaveTodoDetails",
            let todoName = nameTextField.text,
            let todoDescription = descriptionTextView.text {
            todo = TodoItem(name: todoName, description: todoDescription)
            print("prepare")
        }
    }
    
}
