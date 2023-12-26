//
//  HomeViewModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import Foundation

class ItemsViewModel {
    
    private let model: ItemsDataModel = ItemsDataModel()
    public var items: [Item] = [Item]()
    public var filterItems: [Item] = [Item]()
    
    public func saveUserData() {
        model.saveData(saving: items)
    }
    
    public func readUserData() -> [Item] {
        items = model.readData(initialItems: items)
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
            let count = readUserData().filter{ $0.parentCategory == parentCategory }.count
            return count
        }
    }
    
    public var heightForRowAt: CGFloat {
        return 80
    }
}
