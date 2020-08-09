//
//  NewTodoInteractor.swift
//  TODO
//
//  Created by Blink22 on 7/28/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit
import FirebaseStorage

class NewTodoInteractor {
    private var model: TodoList!
    private var newTodo: TodoItem!
    private weak var presenter: NewTodoPresenter?

    init() {
        self.model = TodoList.getInstance()
    }
    
    func addNewTodo(todo: TodoItem, image: UIImage?, presenter: NewTodoPresenter) {
        self.presenter = presenter
        self.newTodo = todo
        if image != nil {
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
                    
                    self.newTodo.imageURL = url.absoluteString
                    print(url)
                    self.model.addNewTodo(todo: self.newTodo) { message, todos in
                        if message == "success" {
                            presenter.newTodoAddedSuccessfully()
                        } else {
                            presenter.newTodoAddingFailed()
                            print ("Error in loading data")
                        }
                    }
                }
            }
        } else {
            self.newTodo.imageURL = "";
            self.model.addNewTodo(todo: self.newTodo) { message, todos in
                if message == "success" {
                    presenter.newTodoAddedSuccessfully()
                } else {
                    presenter.newTodoAddingFailed()
                    print ("Error in loading data")
                }
            }
        }
    }
}
