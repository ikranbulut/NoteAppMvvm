//
//  CategoryViewModel.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import Foundation

final class CategoryViewModel {
  private var selectedCategoryIndex = 0
  private var cameNoteNumber = 0
  
  private var category: Category?
  
  var categories: [Category] = []
  var senderTag: Int?
  
  init(){
    categories = CoreDataManager.shared.fetchCategories()
  }
  
  func saveCategories() {
    CoreDataManager.shared.save()
  }
  
  func delete() {
    if let tag = senderTag, categories.count > -1 {
      CoreDataManager.shared.context.delete(categories[tag])
      categories.remove(at: tag)
    }
    saveCategories()
  }
  
  func addCategory(categoryType: String) {
    let newCategory = Category(context: CoreDataManager.shared.context)
    newCategory.type = categoryType
    categories.append(newCategory)
    saveCategories()
  }
  
  func getCategory(at: Int) -> Category {
    let category = categories[at]
    return category
  }
}
