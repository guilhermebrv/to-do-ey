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
    /*
    public func getCategory() -> [Item] {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                categories = try decoder.decode([Item].self, from: data)
                return categories
            } catch {
                print("error decoding data - \(error.localizedDescription)")
            }
        }
        return [Item]()
    }*/
    
    public var numberOfRowsInSection: Int {
        return categories.count 
        //getCategory().count
    }
    
    public var heightForRowAt: CGFloat {
        return 80
    }
}
