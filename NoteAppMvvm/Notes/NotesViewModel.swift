//
//  NotesViewModel.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit
import CoreData

class NotesViewModel {
    
    var notes: [Note] = []
    var noteNumber = 0
    var selectedNote: Note?
    var enteredPassword = ""
    var category: Category?
    var coreDataManager = CoreDataManager()
    
    public func getNotes(tableView: UITableView){
        guard let categoryType = category?.type else {return}
        notes = coreDataManager.fetchNotes(categoryType: categoryType)
        tableView.reloadData()
    }
   
    public func lockedNote(note: Note) -> String {
        var noteTitle = note.title
        if note.isLocked {
            let stringInputArr = noteTitle!.components(separatedBy: " ")
            var stringNeed = ""
            
            let firstWordLenght = 4
            let stars = "*"
            
            let repeatingStarForForstWord = String(repeating: stars, count: firstWordLenght)
            
            for string in stringInputArr {
                stringNeed = stringNeed + " " + String(string.first!) + repeatingStarForForstWord
            }
            noteTitle = stringNeed
        }
        return noteTitle!
    }
    
    func hideView (view: PasswordView, noteViewModel: NoteViewModel, selectedNotePassword: String,
                   completionhandler: (Bool) -> ())
    {
        if view.enteredPassword == selectedNotePassword {
            noteViewModel.note = selectedNote
            noteViewModel.category = category
            noteViewModel.noteNumber = noteNumber
            view.isHidden = !view.isHidden
            completionhandler(true)
        } else {
            print("wrong password")
           completionhandler(false)
        }
    }

    public func addNote(viewModel: NoteViewModel) {
        viewModel.category = category
        viewModel.isCameFromAddNote = true
    }
}

