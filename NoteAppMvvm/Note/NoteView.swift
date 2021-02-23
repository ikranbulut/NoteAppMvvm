//
//  NoteView.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit


class NoteView: UIViewController {
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteIntentTextView: UITextView!
    @IBOutlet weak var passwordView: PasswordView!
    
    var viewModel = NoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitleTextField.text = viewModel.note?.title
        noteIntentTextView.text = viewModel.note?.intent
        passwordView.layer.cornerRadius = 5
    }
    
    @objc func hideView(sender: UIButton){
        viewModel.hideView(view: passwordView)
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        viewModel.delegate?.deleteNote(noteNumber: viewModel.noteNumber)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func lockButton(_ sender: UIButton) {
        passwordView.isHidden = !passwordView.isHidden
        view.addSubview(passwordView)
        passwordView.enterButton.addTarget(self, action: #selector(hideView(sender:)), for: .touchUpInside)
    }
    @IBAction func saveButton(_ sender: UIButton) {
        viewModel.noteTitle = noteTitleTextField.text!
        viewModel.noteIntent = noteIntentTextView.text!
        viewModel.save()
        dismiss(animated: true, completion: nil)
    }
}
