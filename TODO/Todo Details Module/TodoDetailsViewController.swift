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
    
    private var data = TodoList.getInstance()
    var currentIndexPath: IndexPath?
    var todo: TodoItem?
    private var presenter = TodoDetailsPresenter()
 
    @IBOutlet weak var todoNameTextField: UITextField?
    
    @IBOutlet weak var todoDescriptionTextView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTodoDetails(todo: self.todo!)
        self.todoDescriptionTextView?.becomeFirstResponder()
    }
    
    func setTodoDetails(todo: TodoItem) {
        self.todoNameTextField?.text = todo.name
        self.todoDescriptionTextView?.text = todo.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "SaveTodoChanges",
            let todoName = todoNameTextField!.text,
            let todoDescription = todoDescriptionTextView!.text {
            todo = TodoItem(name: todoName, description: todoDescription)
        }
    }
}
