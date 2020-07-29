//
//  TodoListRouter.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
import UIKit

class TodoListRouter {
    
    func makeNewTodoView(viewController: UIViewController) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let addNewTodo = main.instantiateViewController(withIdentifier: "addNewTodo")
        viewController.present(addNewTodo, animated: true, completion: nil)
    }
    
    func makeTodoDetailsView(viewController: UIViewController, for todo: TodoItem) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let todoDetails = main.instantiateViewController(withIdentifier: "todoDetails") as! TodoDetailsViewController
        todoDetails.todo = todo
        
        viewController.present(todoDetails, animated: true, completion: nil)
    }
    
}
