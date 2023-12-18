//
//  HomeViewModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import UIKit

class HomeViewModel {
    
    let defaults = UserDefaults.standard
    
    var categories: [Item] = [Item(name: "teste", checked: false),Item(name: "teste", checked: false),Item(name: "teste", checked: false),Item(name: "teste", checked: false),Item(name: "teste", checked: false),Item(name: "teste", checked: false)]
    
    public func saveUserData() {
        defaults.set(categories, forKey: "TodoListArray")
    }
    
    public func getCategory() -> [Item] {
        //if let categories = defaults.array(forKey: "TodoListArray") as? [Item] {
        //    return categories
        //}
        return categories
    }
    
    public var numberOfRowsInSection: Int {
        //return defaults.array(forKey: "TodoListArray")?.count ?? 0
        return categories.count
    }
    
    public var heightForRowAt: CGFloat {
        return 100
    }
}
