//
//  TodoListViewController.swift
//  TODO
//
//  Created by Blink22 on 7/28/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class TodoListViewController: UITableViewController {
    
    var data = TodoList.getInstance()
    var presenter = TodoListPresenter()
    
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
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
            self.data.changeCheckMark(index: indexPath)
            if todo.checked {
                tableView.cellForRow(at: indexPath)!.accessoryType = .none
//                let attributeString =  NSMutableAttributedString(string: "Your Text")
//                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
//                                                     value: NSUnderlineStyle.single.rawValue,
//                                                         range: NSMakeRange(0, attributeString.length))
//                (tableView.cellForRow(at: indexPath)! as? TodoItemCell)?.nameLabel.attributedText = attributeString
            } else {
                tableView.cellForRow(at: indexPath)!.accessoryType = .checkmark
            }
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
            self.loadingIndicator.startAnimating()
            if message == "success" {
                self.tableView.reloadData()
            } else {
                print ("Error in loading data")
            }
            self.loadingIndicator.stopAnimating()
            self.loadingView.isHidden = true
        }
    }
}

extension TodoListViewController {
    @IBAction func cancelToTodoListViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func savetodoDetails(_ segue: UIStoryboardSegue) {
        guard
            let newTodoViewController = segue.source as? NewTodoViewController,
            var todo = newTodoViewController.todo
            else {return}
        
        if newTodoViewController.image != nil {
            
            self.loadingIndicator.startAnimating()
            self.loadingView.isHidden = false
            
            let image = newTodoViewController.imageView.image
            let imageData = image?.jpegData(compressionQuality: 0.75)
            let imageName = UUID().uuidString + ".jpeg"
            
            let imageRef = Storage.storage().reference()
                .child("TODO_Images")
                .child(imageName)
            
            imageRef.putData(imageData!, metadata: nil) { (metaData, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                imageRef.downloadURL { (url, err) in
                    if let err = err {
                        print(err.localizedDescription)
                        return
                    }
                    
                    guard let url = url else {
                        print(err!.localizedDescription)
                        return
                    }
                    
                    todo.imageURL = url.absoluteString
                    print(url)
                    self.data.addNewTodo(todo: todo)
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                    
                    self.loadingIndicator.stopAnimating()
                    self.loadingView.isHidden = true
                }
            }
        } else {
            todo.imageURL = "";
            self.data.addNewTodo(todo: todo)
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
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
