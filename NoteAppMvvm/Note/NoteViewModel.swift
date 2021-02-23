//
//  NoteViewModel.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import Foundation

protocol NoteControllerDelegate {
  func deleteNote(noteNumber: Int)
  func getNote (note: Note)
  func addNote (note: Note)
}

final class NoteViewModel {
  private var isLocked = false
  
  private var coreDataManager = CoreDataManager.shared
  
  var noteNumber = 0
  var isCameFromAddNote = false
  var noteTitle = ""
  var noteIntent = ""
  var notePassword = ""
  
  var note: Note?
  var category: Category?
  var delegate: NoteControllerDelegate?
  
  func save() {
    if isCameFromAddNote {
      note = Note(context: coreDataManager.context)
      guard let note = note else { return }
      note.category = category?.type
      note.intent = noteIntent
      note.title = noteTitle
      note.password = notePassword
      note.isLocked = isLocked
      note.parentCategory = category
      delegate?.addNote(note: note)
    } else {
      guard let editedNote = note else { return }
      guard let note = note else { return }
      editedNote.category = note.category
      editedNote.password = note.password
      editedNote.isLocked = note.isLocked
      editedNote.title = noteTitle
      editedNote.intent = noteIntent
      delegate?.getNote(note: editedNote)
    }
  }
  
  func delete() {
    delegate?.deleteNote(noteNumber: noteNumber)
  }
  
  func getPassword() {
    note?.password = notePassword
    note?.isLocked = true
  }
}
