//
//  NotesViewModel.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import Foundation
import CoreData

final class NotesViewModel {
  var notes: [Note] = []
  var noteNumber = 0
  var enteredPassword = ""
  
  var selectedNote: Note?
  var category: Category?
  var coreDataManager = CoreDataManager.shared
  
  func getNotes() {
    guard let categoryType = category?.type else { return }
    notes = coreDataManager.fetchNotes(categoryType: categoryType)
  }
  
  func lockedNote(note: Note) -> String {
  var noteTitle = ""
    if note.isLocked {
      let stringInputArr = note.title!.components(separatedBy: " ")
      var stringNeed = ""
      
      let firstWordLenght = 4
      let stars = "*"
      
      let repeatingStarForForstWord = String(repeating: stars, count: firstWordLenght)
      
      for string in stringInputArr {
        stringNeed = stringNeed + " " + String(string.first!) + repeatingStarForForstWord
      }
      noteTitle = stringNeed
    }
    return noteTitle
  }
  
  func hideView(noteViewModel: NoteViewModel, selectedNotePassword: String, completionhandler: (Bool) -> ()) {
    if enteredPassword == selectedNotePassword {
      noteViewModel.note = selectedNote
      noteViewModel.category = category
      noteViewModel.noteNumber = noteNumber
      completionhandler(true)
    } else {
      completionhandler(false)
    }
  }
  
  func addNote(viewModel: NoteViewModel) {
    viewModel.category = category
    viewModel.isCameFromAddNote = true
  }
}


