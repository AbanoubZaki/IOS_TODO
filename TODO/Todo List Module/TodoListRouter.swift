//
//  TodoListRouter.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit

class TodoListRouter {
    
    func makeNewTodoView(viewController: TodoListViewController) {
        NewTodoRouter().load(viewController: viewController)
    }
    
    func makeTodoDetailsView(viewController: UIViewController, for todo: TodoItem, index: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let todoDetails = main.instantiateViewController(withIdentifier: "todoDetails") as! TodoDetailsViewController
        todoDetails.todo = todo
        todoDetails.currentIndexPath = index
        viewController.present(todoDetails, animated: true, completion: nil)
    }
    
}
