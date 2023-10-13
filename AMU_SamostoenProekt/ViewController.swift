//
//  ViewController.swift
//  AMU_SamostoenProekt
//
//  Created by Ivona on 9/18/23.
//  Copyright © 2023 Ivona. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "register", sender: nil)
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

