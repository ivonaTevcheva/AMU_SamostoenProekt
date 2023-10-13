//
//  RegisterController.swift
//  AMU_SamostoenProekt
//
//  Created by Ivona on 9/19/23.
//  Copyright © 2023 Ivona. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "backSeg", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)) // da ni se pojavi kopche na samiot alert controller so title: "OK"
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            displayAlert(title: "Missing Information", message: "You must provide both, email and password!")
        }
        else{
            if let email = emailTextField.text {
            if let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error != nil { // znachi imame greshka
                    self.displayAlert(title: "Error", message: error!.localizedDescription) // so localizedDescription dobivame opis na greshkata shto se sluchila
                }
                else { // ako nemame greshka
                    print("Sign Up Success")
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: "SignUpSegueNew", sender: nil)
                    }
                }
            }
        }
    }
}
    
    @IBAction func goHereButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goHereSegue", sender: nil)
    }

}

