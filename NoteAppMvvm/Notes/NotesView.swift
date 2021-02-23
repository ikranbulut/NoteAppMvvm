//
//  NotesView.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit

class NotesView: UIViewController{
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    @IBOutlet weak var passwordView: PasswordView!
    
    var cellId = "notesCellId"
    var viewModel = NotesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTitle.text = viewModel.category?.type
        viewModel.getNotes(tableView: notesTableView)
        notesTableView.reloadData()
    }
    
    @IBAction func addNoteButton(_ sender: Any) {
        let noteStroyboard = UIStoryboard(name: "Note", bundle: nil)
        let noteController = noteStroyboard.instantiateViewController(withIdentifier: "NoteVc") as! NoteView
        viewModel.addNote(viewModel: noteController.viewModel)
        noteController.viewModel.delegate = self
        present(noteController, animated: true, completion: nil)
    }
    
    @objc func hideView(sender: UIButton){
        let noteStroyboard = UIStoryboard(name: "Note", bundle: nil)
        let noteController = noteStroyboard.instantiateViewController(withIdentifier: "NoteVc") as! NoteView
        guard let selectedNotePassword = viewModel.selectedNote?.password else {return}
        
        viewModel.hideView(view: passwordView, noteViewModel: noteController.viewModel, selectedNotePassword: selectedNotePassword) { isPassword in
            if isPassword {
                noteController.viewModel.delegate = self
                present(noteController, animated: true, completion: nil)
                
            } else {
                let alertView = UIAlertController(title: "Incorrect entry!", message: "please enter password again", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alertView.dismiss(animated: true) {
                        print("Dismissed.")
                    }
                }))
                present(alertView, animated: true, completion: nil)
            }
        }
    }
}

extension NotesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = notesTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NotesCustomCellView
        
        let row = indexPath.row
        let note = viewModel.notes[row]
        var noteTitle = note.title
        noteTitle = viewModel.lockedNote(note: note)
        
        let cellModel = NotesCustimCellViewModel(noteTitle: noteTitle!)
        cell.cellConfigure(viewModel: cellModel)
        cell.selectedBackgroundView?.backgroundColor = .none
        return cell
    }
}

extension NotesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteStroyboard = UIStoryboard(name: "Note", bundle: nil)
        let noteController = noteStroyboard.instantiateViewController(withIdentifier: "NoteVc") as! NoteView
        let rowNumber = indexPath.row
        let note = viewModel.notes[rowNumber]
        noteController.viewModel.delegate = self
        
        viewModel.selectedNote = note
        viewModel.noteNumber = rowNumber
        viewModel.category = note.parentCategory
        
        if note.isLocked {
            passwordView.isHidden = !passwordView.isHidden
            self.view.addSubview(passwordView)
            passwordView.enterButton.addTarget(self, action: #selector(hideView), for: .touchUpInside)
            
        } else {
            noteController.viewModel.note = note
            noteController.viewModel.category = viewModel.category
            noteController.viewModel.noteNumber = viewModel.noteNumber
            present(noteController, animated: true, completion: nil)
        }
    }
}

extension NotesView: NoteControllerDelegate {
    func addNote(note: Note) {
        viewModel.notes.append(note)
        viewModel.coreDataManager.save()
        notesTableView.reloadData()
    }
    
    func getNote(note: Note) {
        viewModel.notes[viewModel.noteNumber] = note
        viewModel.coreDataManager.save()
        notesTableView.reloadData()
    }
    
    func deleteNote(noteNumber: Int) {
        let context = viewModel.coreDataManager.context
        let notes = viewModel.notes
        context.delete(notes[noteNumber])
        viewModel.notes.remove(at: noteNumber)
        viewModel.coreDataManager.save()
        notesTableView.reloadData()
    }
}
