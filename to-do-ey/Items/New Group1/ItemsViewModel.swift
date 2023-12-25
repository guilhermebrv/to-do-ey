//
//  HomeViewModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import UIKit
import CoreData

class ItemsViewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [Item] = [Item]()
    var filterItems: [Item] = [Item]()
    
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
            items = try context.fetch(request)
        } catch {
            print("error fetching data from context - \(error.localizedDescription)")
        }
        return items
    }

    public func filterSearchText(text: String) {
        if text.isEmpty == true {
            filterItems = items
        } else {
            filterItems = items.filter({ item in
                return item.title?.lowercased().contains(text.lowercased()) ?? false
            })
        }
    }
    
    public func numberOfRowsInSection(filtering: Bool, parentCategory: Category) -> Int {
        if filtering {
            let filteredItemsCount = filterItems.filter{ $0.parentCategory == parentCategory }.count
            return filteredItemsCount
        } else {
            let count = readData().filter{ $0.parentCategory == parentCategory }.count
            return count
        }
    }
    
    public var heightForRowAt: CGFloat {
        return 80
    }
}
