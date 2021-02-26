//
//  CoreDataManager.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit
import CoreData

final class CoreDataManager {
  static let shared = CoreDataManager()
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  private init() {}
  
  func fetchCategories() -> [Category] {
    var categories: [Category] = []
    
    do {
      categories = try context.fetch(Category.fetchRequest())
    } catch {
      print("Error is: \(error)")
    }
    return categories
  }
  
  func fetchNotes(categoryType: String, with request: NSFetchRequest<Note> = Note.fetchRequest(), predicate: NSPredicate? = nil ) -> [Note] {
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
      print("Error fetching data from context: \(error)")
    }
    return notes
  }
  
  func save() {
    
    do {
      try context.save()
    } catch {
      print("Error when saving: \(error)")
    }
  }
}
