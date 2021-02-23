//
//  CoreDataManager.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import CoreData
import UIKit

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func fetchCategories(collectionView: UICollectionView) -> [Category] {
        
        var categories: [Category] = []
        
        do {
            categories = try context.fetch(Category.fetchRequest())
            
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        } catch {
            print("Error loading categories \(error)")
        }
        return categories
    }
    
    
    public func fetchNotes(categoryType: String, with request: NSFetchRequest<Note> = Note.fetchRequest(), predicate: NSPredicate? = nil ) -> [Note]{
        var notes: [Note] = []
        let categoryPredicate = NSPredicate(format: "parentCategory.type MATCHES %@", categoryType)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
           notes = try context.fetch(request)
           
        } catch {
            print("Error fetching data from context \(error)")
        }
        return notes
    }
    
    public func save() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
    }
    
    
}
