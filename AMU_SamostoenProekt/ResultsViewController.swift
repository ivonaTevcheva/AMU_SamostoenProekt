//
//  ResultsViewController.swift
//  AMU_SamostoenProekt
//
//  Created by Ivona on 9/19/23.
//  Copyright © 2023 Ivona. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var time: Int?
    var burnedCalories: Double?
    var distance: Double?
    
    private var shakeCounter = 0 // To keep track of shakes
    
    @IBAction func BackToMainButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "BackToMainSegue", sender: nil)
    }
    
    @IBOutlet weak var labelaShake: UILabel!
    
    @IBOutlet weak var labelaResults: UILabel!
    
    @IBOutlet weak var PrvaLabela: UILabel!
    
    @IBOutlet weak var VtoraLabela: UILabel!
    
    @IBOutlet weak var TretaLabela: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelaShake.isHidden = false
        labelaResults.isHidden = true
        PrvaLabela.isHidden = true
        VtoraLabela.isHidden = true
        TretaLabela.isHidden = true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            revealNextResult()
        }
    }
    
    private func revealNextResult() {
        shakeCounter += 1
        
        switch shakeCounter {
        case 1:
            PrvaLabela.text = "It took you \(time ?? 0) seconds to finish the run"
            PrvaLabela.isHidden = false
            UIView.animate(withDuration: 1) {
                self.PrvaLabela.center = CGPoint(x: self.PrvaLabela.center.x - 500, y: self.PrvaLabela.center.y)
            }
            
        case 2:
            VtoraLabela.text = String(format: "You burned %.2f calories", burnedCalories ?? 0.0)
            VtoraLabela.isHidden = false
            UIView.animate(withDuration: 1) {
                self.VtoraLabela.center = CGPoint(x: self.VtoraLabela.center.x - 500, y: self.VtoraLabela.center.y)
            }
            
        case 3:
            TretaLabela.text = String(format: "You ran %.2f kilometers", distance ?? 0.0)
            TretaLabela.isHidden = false
            UIView.animate(withDuration: 1) {
                self.TretaLabela.center = CGPoint(x: self.TretaLabela.center.x - 500, y: self.TretaLabela.center.y)
            }
            
        default:
            // Do nothing on further shakes
            break
        }
    }
}
