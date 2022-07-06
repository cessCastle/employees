//
//  LoginViewController.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func validate() -> Bool {
        let completed = userNameTextfield.text != "" && passwordTextfield.text != ""
        return completed
    }
    
    func setup() {
        userNameTextfield.delegate = self
        passwordTextfield.delegate = self
        self.changeStateButton()
    }
    func changeStateButton() {
        
        if validate() {
            
            loginButton.isUserInteractionEnabled = true
            loginButton.backgroundColor = .greenDark
            loginButton.alpha = 1.0
        } else {
            loginButton.isUserInteractionEnabled = false
            loginButton.backgroundColor = .lightGray.withAlphaComponent(0.6)
            loginButton.alpha = 0.6
        }
    }
    
    
    func sendData() {
        Loader.shared.showActivityIndicator(viewToPresent: self)
        self.loginViewModel.sendData { (result) in
            Loader.shared.hideActivity()
            switch result {
                case true:
                UserDefaults.standard.set(true, forKey: "session")
                Navigations.shared.showHome(vCToPresent: self)
                break
                
                case false:
                self.errorLabel.isHidden = false
                self.errorLabel.text = self.loginViewModel.mensaje!
                break
                
            }
        }
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        Animations.shared.animateButtonPulse(view: sender, scaleX: 0.9, y: 0.9, duration: 0.1, withImpact: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.validate() {
                self.loginViewModel.user.username = self.userNameTextfield.text!
                self.loginViewModel.user.password = self.passwordTextfield.text!
                self.sendData()
            }
        }
        
    }
    
    
    

}


extension LoginViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.changeStateButton()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.changeStateButton()
    }
}
