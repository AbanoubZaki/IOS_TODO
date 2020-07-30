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
        return data.getCount()
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
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todo = data.todo(at: indexPath)
        let title = todo.checked ? "Uncheck" : "Check";
        let color: UIColor = todo.checked ? .blue : .systemGreen
        let modifyAction = UIContextualAction(style: .normal, title:  title, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.data.changeChackMark(index: indexPath)
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath) as! TodoItemCell
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
            
            print("Update action ...")
            success(true)
        })
        modifyAction.image = UIImage(named: "hammer")
        modifyAction.backgroundColor = color
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = data.todo(at: indexPath)
        presenter.openTodoDetailsView(viewController: self, for: todo, index: indexPath)
    }
    
    @IBAction func openNewTodoView(_ sender: UIBarButtonItem) {
        presenter.openNewTodoView(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        data.load { message, todos in
            if message == "success" {
                self.tableView.reloadData()
            } else {
                print ("Error in loading data")
            }
        }
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
    
    @IBAction func savetodoChanges(_ segue: UIStoryboardSegue) {
        
        print("entered the back code")
        guard
            let todoDetailsViewController = segue.source as? TodoDetailsViewController,
            let todo = todoDetailsViewController.todo,
            let index = todoDetailsViewController.currentIndexPath
            else {return}
        data.editTodo(at: index, newName: todo.name, newDescription: todo.description) { message, todos in
            if message == "success" {
                print ("Todo updated successfully")
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            } else {
                print ("Error in updating todo")
            }
        }
    }
}
