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
    
    private var data = TodoList.getInstance()
    var currentIndexPath: IndexPath?
    var todo: TodoItem?
    private var presenter = TodoDetailsPresenter()
 
    @IBOutlet weak var todoNameTextField: UITextField?
    
    @IBOutlet weak var todoDescriptionTextView: UITextView?
    
    @IBOutlet weak var imageView: UIImageView?
    
    
    @IBOutlet weak var indicatorView: UIView!
    
    @IBOutlet weak var loadingImageIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "SaveTodoChanges",
            let todoName = todoNameTextField!.text,
            let todoDescription = todoDescriptionTextView!.text {
            todo = TodoItem(name: todoName, description: todoDescription)
        }
    }
}
