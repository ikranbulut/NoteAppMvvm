//
//  ViewController.swift
//  NoteAppMvvm
//
//  Created by Mac on 18.02.2021.
//

import UIKit

final class CategoryViewController: UIViewController {
  @IBOutlet weak var categoryCollectionView: UICollectionView!
  
  private let categoryCollectionViewcellIdentifier = "categoryCellIdentifier"
  
  private var viewModel = CategoryViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    categoryCollectionView.reloadData()
  }
  
  @IBAction func addCategory(_ sender: Any) {
    var textField = UITextField()
    
    let backAction = UIAlertAction(title: "Back", style: .default, handler: nil)
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let addAction = UIAlertAction(title: "Add", style: .default) { [self] (action) in
      viewModel.addCategory(categoryType: textField.text!)
      categoryCollectionView.reloadData()
    }
    
    alert.addTextField { (field) in
      textField = field
      textField.placeholder = "Add a new category"
    }
    
    alert.addAction(addAction)
    alert.addAction(backAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  @objc func longPressDelete(sender: UILongPressGestureRecognizer) {
    if sender.state == .ended {
      viewModel.senderTag = sender.view?.tag
      
      let backAction = UIAlertAction(title: "Back", style: .default, handler: nil)
      let alert = UIAlertController(title: "Delete Category", message: "", preferredStyle: .alert)
      let delete = UIAlertAction(title: "Delete", style: .default) { [self] (action) in
        viewModel.delete()
        categoryCollectionView.reloadData()
      }
      
      alert.addAction(backAction)
      alert.addAction(delete)
      
      present(alert, animated: true, completion: nil)
    }
  }
}


extension CategoryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.categories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewcellIdentifier, for: indexPath) as! CategoryCustomCellView
    
    let row = indexPath.row
    let category = viewModel.categories[row]
    let categoryType = category.type
    
    guard let categoryTitle = categoryType else { return cell }
    cell.cellConfigure(with: categoryTitle)
    
    cell.isUserInteractionEnabled = true
    cell.tag = row
    
    let holdToDelete = UILongPressGestureRecognizer(target: self, action: #selector(longPressDelete(sender:)))
    holdToDelete.minimumPressDuration = 0.5
    cell.addGestureRecognizer(holdToDelete)
    
    return cell
  }
}

extension CategoryViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let notesStroyboard = UIStoryboard(name: "Notes", bundle: nil)
    let notesController = notesStroyboard.instantiateViewController(withIdentifier: "NotesVc") as! NotesViewController
    
    let row = indexPath.row
    
    let selectedCategory = viewModel.getCategory(at: row)
    notesController.viewModel.category = selectedCategory
    
    navigationController?.pushViewController(notesController, animated: true)
  }
}
