//
//  TodoListViewController.swift
//  TODO
//
//  Created by Blink22 on 7/28/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit
import FirebaseStorage

class TodoListViewController: UITableViewController {
    
     var presenter = TodoListPresenter()
    
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBAction func openNewTodoView(_ sender: UIBarButtonItem) {
        presenter.openNewTodoView(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadingIndicator.startAnimating()
        presenter.interactor.model.load { message, todos in
            if message == "success" {
                self.reloadView()
            } else {
                print ("Error in loading data")
            }
            self.loadingIndicator.stopAnimating()
            self.loadingView.isHidden = true
        }
    }
}

extension TodoListViewController {
    
    @IBAction func savetodoChanges(_ segue: UIStoryboardSegue) {
        
        print("entered the back code for saving a todo")
        guard
            let todoDetailsViewController = segue.source as? TodoDetailsViewController,
            let todo = todoDetailsViewController.todo,
            let index = todoDetailsViewController.currentIndexPath
            else {return}
            presenter.interactor.model.editTodo(at: index, newName: todo.name, newDescription: todo.description) { message, todos in
            if message == "success" {
                print ("Todo updated successfully")
                self.reloadView()
            } else {
                print ("Error in updating todo")
            }
        }
    }
}

extension TodoListViewController {
    // size of the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.interactor.model.getCount()
    }
    
    // builds each cell in the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath) as! TodoItemCell
        cell.todo = presenter.interactor.model.todo(at: indexPath)
    
        return cell
    }
    
    // swipe for left to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            presenter.deleteTodo(todo : (presenter.interactor.model.todo(at: indexPath)))
            self.reloadView()
        }
    }
    
    // swipe for right to check/uncheck
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todo = presenter.interactor.model.todo(at: indexPath)
        let title = todo.checked ? "Uncheck" : "Check";
        let color: UIColor = todo.checked ? .blue : .systemGreen
        let modifyAction = UIContextualAction(style: .normal, title:  title, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.presenter.interactor.model.changeCheckMark(index: indexPath)
            if todo.checked {
                tableView.cellForRow(at: indexPath)!.accessoryType = .none
            } else {
                tableView.cellForRow(at: indexPath)!.accessoryType = .checkmark
            }
            success(true)
        })
        modifyAction.image = UIImage(named: "hammer")
        modifyAction.backgroundColor = color
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    // on cell click go to its details view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = presenter.interactor.model.todo(at: indexPath)
        presenter.openTodoDetailsView(viewController: self, for: todo, index: indexPath)
    }
}

extension TodoListViewController {
    func reloadView () {
        DispatchQueue.main.async{
            print(String(self.presenter.interactor.model.getCount()) + "from reloading")
            self.tableView.reloadData()
        }
    }
}
