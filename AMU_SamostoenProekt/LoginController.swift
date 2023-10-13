//
//  LoginController.swift
//  AMU_SamostoenProekt
//
//  Created by Ivona on 9/19/23.
//  Copyright © 2023 Ivona. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

    @IBOutlet weak var emailTextF: UITextField!
    
    @IBOutlet weak var passwordTextF: UITextField!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "backSegue", sender: nil)
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)) // da ni se pojavi kopche na samiot alert controller so title: "OK"
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func LogInButtonPressed(_ sender: Any) {
        if emailTextF.text == "" || passwordTextF.text == "" { // proveruvame dali email i pw se prazni
            displayAlert(title: "Missing Information", message: "You must provide both, email and password!") // kako poraka kazhi deka mora da se popolnat polinjata
        }
        else { // ako dvete polinja se popolneti
            if let email = emailTextF.text {
                if let password = passwordTextF.text {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in // namesto createUser pravime signIn
        if error != nil {
            self.displayAlert(title: "Error", message: error!.localizedDescription)
        }
        else { // ako nemame greshka
            print("Log In Success")
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
                    }
                }
            }
        }
    }
    
    @IBAction func CreateNewButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "registerSeg", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
