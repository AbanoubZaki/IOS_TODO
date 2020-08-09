//
//  NewTodoViewController.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit

class NewTodoViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var todo: TodoItem!
    var image: UIImage?
    
    var imagePicker = UIImagePickerController()
    var presenter: NewTodoPresenter!
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        presenter.close()
    }
    
    @IBAction func addNewTodoButton(_ sender: UIBarButtonItem) {
        addNewTodoIndicator.startAnimating()
        
        if isValidTodo() {
            let todo = makeNewTodo()
            presenter.addNewTodo(todo: todo, image: self.image)
        } else {
            addNewTodoIndicator.stopAnimating()
        }
    }
    
    @IBOutlet weak var addNewTodoIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewTodoPresenter(view: self, interactor: NewTodoInteractor(), router: NewTodoRouter())
        
        nameTextField.becomeFirstResponder()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
            image = imageView.image
        }
        picker.allowsEditing = true
        dismiss(animated: true, completion: nil)
    }
    
}

extension NewTodoViewController {
    func close () {
        self.dismiss(animated: true)
    }
    
    func newTodoAddingFailed () {
        addNewTodoIndicator.stopAnimating()
    }
    
    func isValidTodo () -> Bool {
        if nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let dialogMessage = UIAlertController(title: "A new todo couldn't be added!",
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
    
    func makeNewTodo () -> TodoItem {
        var todo: TodoItem?
        if let todoName = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let todoDescription = descriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            todo = TodoItem(name: todoName, description: todoDescription)
            print("prepare for a new todo")
        }
        return todo!
    }
}
