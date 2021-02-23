//
//  PassswordView.swift
//  NoteAppMvvm
//
//  Created by Mac on 21.02.2021.
//

import UIKit

final class PasswordView: UIView {
  @IBOutlet weak var passwordView: UIView!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var enterButton: UIButton!
  @IBOutlet weak var securityButton: UIButton!
  
  var enteredPassword = ""
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    passwordView.endEditing(true)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  @IBAction func securityButton(_ sender: UIButton) {
    passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("PasswordView", owner: self, options: nil)
    addSubview(passwordView)
    passwordView.frame = self.bounds
    passwordView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.passwordView.topAnchor.constraint(equalTo: self.topAnchor),
      self.passwordView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.passwordView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.passwordView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    ])
    enterButton.layer.cornerRadius = 3
  }
}


extension PasswordView : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    passwordTextField.endEditing(true)
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    securityButton.isHidden = false
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    enteredPassword = passwordTextField.text!
    securityButton.isHidden = true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if passwordTextField.text != "" && passwordTextField.text?.count == 4 {
      enteredPassword = passwordTextField.text!
      return true
    } else {
      passwordTextField.placeholder = "Enter a password"
      return false
    }
  }
}
