//
//  CategoryViewModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 22/12/2023.
//

import UIKit
import CoreData

class CategoryViewModel: NSObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    public var categories: [Category] = [Category]()
    public var filterCategories: [Category] = [Category]()
    
    public func saveUserData() {
        do {
            try context.save()
        } catch {
            print("error saving context - \(error.localizedDescription)")
        }
    }
    
    public func readData() -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("error fetching data from context - \(error.localizedDescription)")
        }
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
            return readData().count
        }
    }
    
    public var heightForRowAt: CGFloat {
        return 80
    }
}
