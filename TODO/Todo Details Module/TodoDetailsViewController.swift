//
//  TodoDetailsViewController.swift
//  TODO
//
//  Created by Blink22 on 7/29/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class TodoDetailsViewController: UITableViewController {
    
    var currentIndexPath: IndexPath!
    var todo: TodoItem!
    private var presenter: TodoDetailsPresenter!
 
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.close()
    }
    
    @IBOutlet weak var todoNameTextField: UITextField?
    
    @IBOutlet weak var todoDescriptionTextView: UITextView?
    
    @IBOutlet weak var imageView: UIImageView?
    
    
    @IBOutlet weak var indicatorView: UIView!
    
    @IBOutlet weak var loadingImageIndicator: UIActivityIndicatorView!
    
    @IBAction func saveChangesButton(_ sender: UIButton) {
        if let todoName = todoNameTextField!.text,
            self.isValidTodo(),
            let todoDescription = todoDescriptionTextView!.text {
            let editedTodo = TodoItem(name: todoName, description: todoDescription)
            
            presenter.editTodo(for: editedTodo, index: self.currentIndexPath)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TodoDetailsPresenter(view: self, interactor: TodoDetailsInteractor(), router: TodoDetailsRouter())

        setTodoDetails(todo: self.todo!)
        self.todoDescriptionTextView?.becomeFirstResponder()
    }
    
    func setTodoDetails(todo: TodoItem) {
        self.todoNameTextField?.text = todo.name
        self.todoDescriptionTextView?.text = todo.description
        
        if todo.imageURL == "" {
            loadingImageIndicator.stopAnimating()
            indicatorView.isHidden = true
        } else {
            loadingImageIndicator.startAnimating()
            indicatorView.isHidden = false
            
            let imageURL = todo.imageURL
            let imageRef = Storage.storage().reference(forURL: imageURL)
            imageRef.getData(maxSize: 5 * 1024 * 1024) { (data, error) -> Void in
                let image = UIImage(data: data!)
                self.imageView?.image = image
                
                self.loadingImageIndicator.stopAnimating()
                self.indicatorView.isHidden = true
            }
        }
    }
}

extension TodoDetailsViewController {
    func close () {
        self.dismiss(animated: true)
    }
    
    func isValidTodo () -> Bool {
        if todoNameTextField!.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let dialogMessage = UIAlertController(title: "Todo couldn't be edited!",
                                                  message: "Todo name couldn't be left empty.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            
            dialogMessage.addAction(ok)
            present(dialogMessage, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }
    }
}
