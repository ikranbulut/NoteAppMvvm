//
//  NotesCustomCellView.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit

final class NotesCustomCellView: UITableViewCell {
  @IBOutlet weak var noteTitleLabel: UILabel!
  
  func cellConfigure(with title: String) {
    noteTitleLabel.text = title
  }
}
