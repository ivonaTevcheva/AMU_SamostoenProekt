//
//  TableViewController.swift
//  AMU_SamostoenProekt
//
//  Created by Ivona on 9/19/23.
//  Copyright © 2023 Ivona. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TableViewController: UITableViewController {
    
    
    @IBAction func backRecordsButton(_ sender: Any) {
        performSegue(withIdentifier: "backRecordsSegue", sender: nil)
    }
    
    var runs: [Run] = [] // kreira niza runs od modelite Run kaj shto kje gi stava site od Firebase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // koga imame kreirano custom kelija kelijaTableViewCell.swift so ova nib vsushnost se registrira kelijata
        // kelijaTableViewCell.swift se kreira zaedno so kelijaTableViewCell.xib kade shto vo prvoto se naogja kodot za kelijata, a vtoroto e storyboard-ot za samata kelija
        let nib = UINib(nibName: "kelijaTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "kelija")
        loadRuns()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kelija", for: indexPath) as! kelijaTableViewCell
        
        let run = runs[indexPath.row]
        cell.configure(with: run)
        
        return cell
    }
    
    func loadRuns() {
        let ref = Database.database().reference().child("runs") // od baza ja vleche tabelata runs; potoa gi vrti site redici od runs za onoj korisnik shto e najaven
        
        // ova vo red 53 e kako query vo java, oti e vo realtime, vsushnost so observe se vrtat podatocite
        ref.observe(.value, with: { [weak self] (snapshot) in
            var loadedRuns: [Run] = []
            let currentUser = Auth.auth().currentUser?.email
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let runDict = childSnapshot.value as? [String: Any],
                    let run = Run(from: runDict) { // ova gore e za podatocite od Firebase da gi pretvori vo model vo swift
                    if run.userEmail == currentUser {
                        loadedRuns.append(run)
                    }
                }
            }
            
            self?.runs = loadedRuns // vratenite podatoci gi stava vo nizata shto ja kreiravme na pochetok
            self?.tableView.reloadData()
        })
    }
}

