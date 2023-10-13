//
//  TresenjeEkran.swift
//  AMU_SamostoenProekt
//
//  Created by Ivona on 9/20/23.
//  Copyright © 2023 Ivona. All rights reserved.
//

import UIKit

class TresenjeEkran: UIViewController {
    
    var timer = Timer()
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(prikazhiRez), userInfo: nil, repeats: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func prikazhiRez(){
        performSegue(withIdentifier: "prikazhiRezultati", sender: nil)
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
