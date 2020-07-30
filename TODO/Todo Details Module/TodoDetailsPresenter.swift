//
//  TodoDetailsPresenter.swift
//  TODO
//
//  Created by Blink22 on 7/29/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class TodoDetailsPresenter: ObservableObject {
    private let interactor: TodoDetailsInteractor
        
    init() {
        self.interactor = TodoDetailsInteractor()
    }

    
}
