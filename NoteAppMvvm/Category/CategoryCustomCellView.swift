//
//  CategoryCustomCellView.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit

class CategoryCustomCellView: UICollectionViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    public func cellConfigure( with viewModel: CategoryCustomCellViewModel){
        categoryLabel.text = viewModel.categoryLabel
    }
}
