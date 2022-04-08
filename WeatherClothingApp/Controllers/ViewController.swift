//
//  ViewController.swift
//  WeatherClothingApp
//
//  Created by Gian Membreno on 3/7/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainScreenBackground: UIImageView!
    @IBOutlet weak var refreshLocationButton: UIButton!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        
        switch hour {
            case 3...11:
                mainScreenBackground.image = UIImage(named: "backgroundEarlyMorning")
            case 12...17:
                mainScreenBackground.image = UIImage(named: "backgroundAfterNoon")
            default:
                mainScreenBackground.image = UIImage(named: "backgroundEvening")
        }
        
    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        let secondVC = SecondViewController()
        
        self.present(secondVC, animated: true, completion: nil)
    }
    


}

