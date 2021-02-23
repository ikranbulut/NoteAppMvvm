//
//  NoteViewModel.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit

protocol NoteControllerDelegate {
    func deleteNote(noteNumber: Int)
    func getNote (note: Note)
    func addNote (note: Note)
}

class NoteViewModel {
    
    var noteNumber = 0
    var note: Note?
    var isCameFromAddNote = false
    var noteTitle = ""
    var noteIntent = ""
    var notePassword = ""
    var isLocked = false
    var category: Category?
    var delegate: NoteControllerDelegate?
    var coreDataManager = CoreDataManager()
    
    func save() {
        if isCameFromAddNote {
            note = Note(context: coreDataManager.context)
            note!.category = category?.type
            note!.intent = noteIntent
            note!.title = noteTitle
            note!.password = notePassword
            note!.isLocked = isLocked
            note!.parentCategory = category
            delegate?.addNote(note: note!)
            
        } else {
            guard let editedNote = note else {return}
            editedNote.category = note!.category
            editedNote.password = note!.password
            editedNote.isLocked = isLocked
            editedNote.title = note?.title
            editedNote.intent = note!.intent
            dump(editedNote)
            delegate?.getNote(note: editedNote)
        }
    }
    
func hideView(view: PasswordView ){
        view.enteredPassword = view.passwordTextField.text!
        notePassword = view.enteredPassword
        print(notePassword)
        isLocked = true
        view.isHidden = !view.isHidden
    }
    
}
