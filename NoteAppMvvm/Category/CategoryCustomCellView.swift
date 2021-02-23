//
//  CategoryCustomCellView.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit

final class CategoryCustomCellView: UICollectionViewCell {
  @IBOutlet weak var categoryTitle: UILabel!

  func cellConfigure(with title: String) {
    categoryTitle.text = title
  }
}
