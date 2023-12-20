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
        return categories
    }
    
    public var numberOfRowsInSection: Int {
        return readData().count 
    }
    
    public var heightForRowAt: CGFloat {
        return 80
    }
}
