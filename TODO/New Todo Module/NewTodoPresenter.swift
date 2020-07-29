//
//  NewTodoPresenter.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
class NewTodoPresenter: ObservableObject {
    private let interactor: NewTodoInteractor

    init(interactor: NewTodoInteractor) {
        self.interactor = interactor
    }
}
