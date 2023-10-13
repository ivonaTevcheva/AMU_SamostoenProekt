//
//  MapController.swift
//  AMU_SamostoenProekt
//
//  Created by Ivona on 9/19/23.
//  Copyright © 2023 Ivona. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import FirebaseDatabase
import FirebaseAuth

class MapController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // mapata bara dozvola za lokacija
        locationManager.startUpdatingLocation() // predefinirana funkcija koja ja chita lokacijata kade shto se naogja user-ot
        mapata.showsUserLocation = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true) // pochnuva da teche tajmerot; updateTime e nasha funkcija
        
    }
    
    var previousLocation: CLLocation?
    var totalDistance = 0.0
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Current location: \(location)")
            
            // Zooming to the location: zumira vo momentalnata lokacija
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapata.setRegion(region, animated: true)
            
            // Adding the start pin: pincheto shto se dodava za da go oznachi pochetokot na trkata
            if previousLocation == nil {
                let startPin = MKPointAnnotation()
                startPin.coordinate = location.coordinate
                startPin.title = "Start"
                mapata.addAnnotation(startPin)
            }
            
            // Calculating total distance: predefinirana funkcija koja avtomatski go broi rastojanieto shto go istrchal user-ot
            if let previousLocation = previousLocation {
                totalDistance += location.distance(from: previousLocation)
            }
            
            previousLocation = location
        }
    }
    
    @IBAction func kopceNazad(_ sender: Any) {
        performSegue(withIdentifier: "vratiNazadSeg", sender: nil)
    }
    
    
    @IBOutlet weak var DistanceLabel: UILabel!
    
    @IBOutlet weak var mapata: MKMapView!
    
    @IBOutlet weak var labelaMinuti: UILabel!
    
    @IBOutlet weak var labelaSekundi: UILabel!
    
    
    @IBAction func finishRunButtonPressed(_ sender: Any) {
        let distanceInKilometers = totalDistance / 1000 // Convert meters to kilometers
        print("You ran \(distanceInKilometers) kilometers!")
        let timeTaken = minutes * 60 + seconds
        if let userEmail = Auth.auth().currentUser?.email { // go vrakja najaveniot user i za nego kreiraj model Run so toj email, kilometri i time.
            // Vsushnost vo Run.swift so vleznite parametri(email, kilometri i time) se pravi presmetka za potroshenite kalorii.
            let run = Run(userEmail: userEmail, kilometers: distanceInKilometers, time: timeTaken)

            // Saving to Firebase Realtime Database
            let runReference = Database.database().reference().child("runs").childByAutoId()
            runReference.setValue(run.toDictionary()) { error, _ in
                if let error = error {
                    print("Error adding run: \(error)")
                } else {
                    print("Run added successfully!")
                    self.performSegue(withIdentifier: "tresenjeEkran", sender: nil)
                }
            }
        } else {
            print("No user is currently logged in or user does not have an email.")
            // Handle this error case as per your needs
        }
    }
    
    var timer: Timer?
    var minutes = 0
    var seconds = 0
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        seconds += 1
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        labelaMinuti.text = String(minutes)
        labelaSekundi.text = String(seconds)
        DistanceLabel.text = String(totalDistance) + "m"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tresenjeEkran",
           let destinationVC = segue.destination as? ResultsViewController {
            let distanceInKilometers = totalDistance / 1000 // Convert meters to kilometers

            // Calculate burned calories. For the sake of simplicity, I'm using a basic calculation.
            // Please adjust this calculation as per your requirements or actual algorithm.
            let caloriesPerKilometer = 60.0  // Example value, adjust as needed.
            let burnedCalories = distanceInKilometers * caloriesPerKilometer

            destinationVC.time = minutes * 60 + seconds
            destinationVC.burnedCalories = burnedCalories
            destinationVC.distance = distanceInKilometers
        }
    }
    
}
