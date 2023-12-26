//
//  CategoriesDataModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 26/12/2023.
//

import CoreData
import UIKit

class CategoriesDataModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    public func saveData(saving: [Category]) {
        do {
            try context.save()
        } catch {
            print("error saving context - \(error.localizedDescription)")
        }
    }

    public func readData(initialCategories: [Category]) -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        var categories = initialCategories
                
        do {
            categories = try context.fetch(request)
        } catch {
            print("error fetching data from context - \(error.localizedDescription)")
        }
        return categories
    }
}
