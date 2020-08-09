//
//  TodoDetailsRouter.swift
//  TODO
//
//  Created by Blink22 on 8/9/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit

class TodoDetailsRouter {
    
    internal weak var delegate: TodoListViewController?
    
    func load (viewController: UIViewController, for todo: TodoItem, index: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let todoDetails = main.instantiateViewController(withIdentifier: "todoDetails") as! TodoDetailsViewController
        todoDetails.todo = todo
        todoDetails.currentIndexPath = index
        todoDetails.modalPresentationStyle = .fullScreen

        viewController.present(todoDetails, animated: true, completion: nil)
    }
}
