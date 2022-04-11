//
//  WeatherData.swift
//  WeatherClothingApp
//
//  Created by Gian Membreno on 4/10/22.
//

import Foundation

struct WeatherData: Codable{
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable{
    let temp: Double
}

struct Weather: Codable{
    let description: String
    let id: Int
}

