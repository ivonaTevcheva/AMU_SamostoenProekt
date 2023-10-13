//
//  prvEkran.swift
//  AMU_SamostoenProekt
//
//  Created by Ivona on 9/19/23.
//  Copyright © 2023 Ivona. All rights reserved.
//

import UIKit

class prvEkran: UIViewController {
    
    
    @IBAction func NewRunSlika(_ sender: Any) {
        performSegue(withIdentifier: "NewRunSlikaSegue", sender: nil)
    }
    
    @IBAction func NewRunButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "NewRunSegue", sender: nil)
    }
    
    @IBAction func RecordsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "recordsSeg", sender: nil)
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
