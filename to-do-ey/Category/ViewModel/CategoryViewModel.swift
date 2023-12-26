//
//  CategoryViewModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 22/12/2023.
//

import Foundation

class CategoryViewModel {
    
    private let model: CategoriesDataModel = CategoriesDataModel()
    public var categories: [Category] = [Category]()
    public var filterCategories: [Category] = [Category]()
    
    public func saveUserData() {
        model.saveData(saving: categories)
    }
    
    public func readUserData() -> [Category] {
        categories = model.readData(initialCategories: categories)
        return categories
    }
    
    public func filterSearchText(text: String) {
        if text.isEmpty == true {
            filterCategories = categories
        } else {
            filterCategories = categories.filter({ category in
                return category.name?.lowercased().contains(text.lowercased()) ?? false
            })
        }
    }
    
    public func numberOfRowsInSection(filtering: Bool) -> Int {
        if filtering {
            return filterCategories.count
        } else {
            return readUserData().count
        }
    }
    
    public var heightForRowAt: CGFloat {
        return 80
    }
}
