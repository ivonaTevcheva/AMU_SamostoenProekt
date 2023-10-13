//
//  Run.swift
//  AMU_SamostoenProekt
//
//  Created by Ivona on 9/20/23.
//  Copyright © 2023 Ivona. All rights reserved.
//

import UIKit

class Run: NSObject {
    var userEmail: String
    var kilometers: Double
    var time: Int // time in seconds
    var caloriesBurned: Double

    init(userEmail: String, kilometers: Double, time: Int) { // konstruktor
        self.userEmail = userEmail
        self.kilometers = kilometers
        self.time = time
        self.caloriesBurned = Run.calculateCalories(kilometers: kilometers, time: time) // a simplistic calorie calculator
    }
    
    init(userEmail: String, kilometers: Double, time: Int, caloriesBurned: Double) { // i ova e konstruktor no so razlichni parametri
        self.userEmail = userEmail
        self.kilometers = kilometers
        self.time = time
        self.caloriesBurned = caloriesBurned
    }

    static func calculateCalories(kilometers: Double, time: Int) -> Double { // presmetuva potrosheni kalorii
        // This is a very basic calculation and may not be accurate. You might want to use a more detailed calculation.
        let avgSpeed = kilometers / Double(time) * 3600.0 // in km/h
        if avgSpeed < 8.0 {
            return kilometers * 60.0 // jogging
        } else {
            return kilometers * 70.0 // running
        }
    }

    // Convert model to dictionary for Firebase
    func toDictionary() -> [String: Any] {
        return [
            "userEmail": userEmail,
            "kilometers": kilometers,
            "time": time,
            "caloriesBurned": caloriesBurned
        ]
    }
}

extension Run { // obraten konstruktor ustvari koga gi zemame od Firebase podatocite da gi pretvori vo swift
    // Initializer to create a Run instance from a dictionary
    convenience init?(from dictionary: [String: Any]) {
        guard
            let userEmail = dictionary["userEmail"] as? String,
            let kilometers = dictionary["kilometers"] as? Double,
            let time = dictionary["time"] as? Int,
            let caloriesBurned = dictionary["caloriesBurned"] as? Double
        else {
            return nil
        }

        self.init(userEmail: userEmail, kilometers: kilometers, time: time, caloriesBurned: caloriesBurned)
    }
}
