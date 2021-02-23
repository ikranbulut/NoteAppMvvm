//
//  ViewController.swift
//  NoteAppMvvm
//
//  Created by Mac on 18.02.2021.
//

import UIKit

class CategoryView: UIViewController {

    let cellId = "categoryCellIdentifier"
    var viewModel = CategoryViewModel()
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        //        title attr.
        self.navigationController?.navigationBar.titleTextAttributes =  [.font: UIFont.boldSystemFont(ofSize: 26)]
        viewModel.getCategories(collectionView: categoryCollectionView)
        categoryCollectionView.reloadData()
    }
    @IBAction func addCategory(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)

        let addAction = UIAlertAction(title: "Add", style: .default) { [self] (action) in
          
            viewModel.addCategory(collectionView: categoryCollectionView, categoryType: textField.text!)
            categoryCollectionView.reloadData()
        }
        
        let backAction = UIAlertAction(title: "Back", style: .default, handler: nil)

        alert.addAction(addAction)
        alert.addAction(backAction)

        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }

        present(alert, animated: true, completion: nil)
    }
    
    @objc func longPressDelete(sender: UILongPressGestureRecognizer ) {
        if sender.state == .began {
            print(" gesture recognizer : tapped about 2 ms")
        }
        if sender.state == .ended {
            viewModel.senderTag = sender.view!.tag
            let alert = UIAlertController(title: "Delete Category", message: "", preferredStyle: .alert)
            let delete = UIAlertAction(title: "Delete", style: .default) { [self] (action) in
                viewModel.delete(collectionView: categoryCollectionView)
            }
            let backAction = UIAlertAction(title: "Back", style: .default, handler: nil)
            alert.addAction(delete)
            alert.addAction(backAction)
            present(alert, animated: true, completion: nil)
            
        }
    }
}


extension CategoryView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCustomCellView
        
        let row = indexPath.row
        let category = viewModel.categories[row] 
        let categoryType = category.type
        let cellModel = CategoryCustomCellViewModel(categoryLabel: categoryType!)

        cell.cellConfigure(with: cellModel)
        cell.isUserInteractionEnabled = true
        cell.tag = row
        let holdToDelete = UILongPressGestureRecognizer(target: self, action: #selector(longPressDelete(sender:)))
        holdToDelete.minimumPressDuration = 0.5
        cell.addGestureRecognizer(holdToDelete)
        return cell
    }
}

extension CategoryView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped \(indexPath.row)")
        
        let notesStroyboard = UIStoryboard(name: "Notes", bundle: nil)
        let notesController = notesStroyboard.instantiateViewController(withIdentifier: "NotesVc") as! NotesView
        
        let row = indexPath.row
        let category = viewModel.categories[row]
        
        notesController.viewModel.category = category
 
        navigationController?.pushViewController(notesController, animated: true)

    }
}
