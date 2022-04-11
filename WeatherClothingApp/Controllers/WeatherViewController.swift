//
//  ViewController.swift
//  WeatherClothingApp
//
//  Created by Gian Membreno on 3/7/22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var mainScreenBackground: UIImageView!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    let hour = Calendar.current.component(.hour, from: Date())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        switch hour {
            case 3...11:
                mainScreenBackground.image = UIImage(named: "backgroundEarlyMorning")
            case 12...17:
                mainScreenBackground.image = UIImage(named: "backgroundAfterNoon")
            default:
                mainScreenBackground.image = UIImage(named: "backgroundEvening")
        }
        
    }
}

    
//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
        
    @IBAction func searchPressed(_ sender: UIButton){
        searchTextField.endEditing(true)
    }
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchTextField.endEditing(true)
            return true
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != "" {
                return true
            } else {
                textField.placeholder = "Type something"
                return false
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            if let city = searchTextField.text {
                weatherManager.fetchWeather(cityName: city)
            }
            
            searchTextField.text = ""
            
        }
    }
    
    
    
//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
        func didFailWithError(error: Error){
            print(error)
        }
        
    }


//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
