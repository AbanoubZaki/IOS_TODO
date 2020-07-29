//
//  TodoListViewController.swift
//  TODO
//
//  Created by Blink22 on 7/28/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
import UIKit

class TodoListViewController: UITableViewController {
    
    var data = TodoList.getInstance()
    var presenter = TodoListPresenter()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath) as! TodoItemCell
        cell.todo = data.todo(at: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            presenter.deleteTodo(todo : (data.todo(at: indexPath)))
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = data.todo(at: indexPath)
        presenter.openTodoDetailsView(viewController: self, for: todo)
    }
    
    @IBAction func openNewTodoView(_ sender: UIBarButtonItem) {
        presenter.openNewTodoView(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
}

extension TodoListViewController {
    @IBAction func cancelToTodoListViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func savetodoDetails(_ segue: UIStoryboardSegue) {
        guard
            let newTodoViewController = segue.source as? NewTodoViewController,
            let todo = newTodoViewController.todo
            else {return}
        data.addNewTodo(todo: todo)
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
}
