//
//  HomeViewModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import UIKit
import CoreData

class HomeViewModel {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories: [Item] = [Item]()
    var filterCategories: [Item] = [Item]()
    
    public func saveUserData() {
        do {
            try context.save()
        } catch {
            print("error saving context - \(error.localizedDescription)")
        }
    }
    
    public func readData() -> [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("error fetching data from context - \(error.localizedDescription)")
        }
        filterCategories = categories
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
