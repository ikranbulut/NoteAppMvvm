//
//  CategoryViewModel.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit

class CategoryViewModel {
    
    var categories: [Category] = []
    var category: Category?
    var selectedCategoryIndex = 0
    var cameNoteNumber = 0
    var senderTag: Int?

    var coreDataManager = CoreDataManager()
    
    public func getCategories(collectionView: UICollectionView) {
        categories = coreDataManager.fetchCategories(collectionView: collectionView)
    }
    
    public func saveCategories(collectionView: UICollectionView) {
        coreDataManager.save()
        collectionView.reloadData()
    }
    
    func delete(collectionView: UICollectionView) {
        if let tag = senderTag, categories.count > -1 {
            coreDataManager.context.delete(categories[tag])
            categories.remove(at: tag)
        }
        saveCategories(collectionView: collectionView)
    }

    func addCategory(collectionView: UICollectionView, categoryType: String ) {
        let newCategory = Category(context: coreDataManager.context)
        newCategory.type = categoryType
        categories.append(newCategory)
        saveCategories(collectionView: collectionView )
    }
}

