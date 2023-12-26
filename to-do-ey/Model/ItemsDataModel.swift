//
//  ItemsDataModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 26/12/2023.
//

import CoreData
import UIKit

class ItemsDataModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    public func saveData(saving: [Item]) {
        do {
            try context.save()
        } catch {
            print("error saving context - \(error.localizedDescription)")
        }
    }

    public func readData(initialItems: [Item]) -> [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        var items = initialItems
                
        do {
            items = try context.fetch(request)
        } catch {
            print("error fetching data from context - \(error.localizedDescription)")
        }
        return items
    }
}
