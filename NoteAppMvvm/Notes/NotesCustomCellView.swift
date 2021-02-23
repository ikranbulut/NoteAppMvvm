//
//  NotesCustomCellView.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit
class NotesCustomCellView: UITableViewCell {
    
    @IBOutlet weak var noteTitleLabel: UILabel!
    
    public func cellConfigure(viewModel: NotesCustimCellViewModel) {
        noteTitleLabel.text = viewModel.noteTitle
    }
}
