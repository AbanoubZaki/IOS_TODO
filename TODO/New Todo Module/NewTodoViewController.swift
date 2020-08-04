//
//  NewTodoViewController.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit

class NewTodoViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var todo: TodoItem?
    var image: UIImage?
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "SaveTodoDetails",
            let todoName = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let todoDescription = descriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            todo = TodoItem(name: todoName, description: todoDescription)
            print("prepare for a new todo")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "SaveTodoDetails" {
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
        return true
    }
    
}
