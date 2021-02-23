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
  
  private var coreDataManager = CoreDataManager.shared
  private var category: Category?
  
  var categories: [Category] = []
  var senderTag: Int?
  
  func getCategories() {
    categories = coreDataManager.fetchCategories()
  }
  
  func saveCategories() {
    coreDataManager.save()
  }
  
  func delete() {
    if let tag = senderTag, categories.count > -1 {
      coreDataManager.context.delete(categories[tag])
      categories.remove(at: tag)
    }
    saveCategories()
  }
  
  func addCategory(categoryType: String) {
    let newCategory = Category(context: coreDataManager.context)
    newCategory.type = categoryType
    categories.append(newCategory)
    saveCategories()
  }
}
