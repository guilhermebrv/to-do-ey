//
//  HomeViewModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import UIKit

class HomeViewModel {
    
    let defaults = UserDefaults.standard
    
    var categories: [String] = ["Teste1", "Teste2", "Teste3", "Teste4", "Teste5"]
    
    public func saveUserData() {
        defaults.set(categories, forKey: "TodoListArray")
    }
    
    public func getCategory() -> [String] {
        if let categories = defaults.array(forKey: "TodoListArray") as? [String] {
            return categories
        }
        return categories
    }
    
    public var numberOfRowsInSection: Int {
        return defaults.array(forKey: "TodoListArray")?.count ?? 5
    }
    
    public var heightForRowAt: CGFloat {
        return 100
    }
}
