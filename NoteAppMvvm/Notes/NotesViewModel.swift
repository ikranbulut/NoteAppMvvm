//
//  NotesViewModel.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit
import CoreData

final class NotesViewModel {
  var notes: [Note] = []
  var noteNumber = 0
  var enteredPassword = ""
  
  var selectedNote: Note?
  var category: Category?
 
  func getNotes() {
    guard let categoryType = category?.type else { return }
    notes = CoreDataManager.shared.fetchNotes(categoryType: categoryType)
  }
  
  func lockedNote(note: Note) -> String {
    guard let noteTitle = note.title else { return ""}
    
    var lockedTitle = ""
    var repeatingString = ""
    let star = "*"
    var firstChar = ""
    
    if note.isLocked {
      let seperatedTitle = noteTitle.components(separatedBy: " ")
      for (index, parsedWord) in seperatedTitle.enumerated() {
        firstChar = String(parsedWord.prefix(1))
        
        let repeatCount = parsedWord.count - 1
        
        repeatingString  = String(repeating: star, count: repeatCount)
        
        if index == 0{
          lockedTitle = firstChar.uppercased() + repeatingString
        } else {
          lockedTitle += " " + firstChar.uppercased() + repeatingString
        }
        
      }
    }
    return lockedTitle
  }
  
  func hideView(noteViewModel: NoteViewModel, selectedNotePassword: String, completionHandler: (Bool) -> ()) {
    if enteredPassword == selectedNotePassword {
      noteViewModel.note = selectedNote
      noteViewModel.category = category
      noteViewModel.noteNumber = noteNumber
      completionHandler(true)
    } else {
      completionHandler(false)
    }
  }
  
  func addNote(viewModel: NoteViewModel) {
    viewModel.category = category
    viewModel.isCameFromAddNote = true
  }
}


