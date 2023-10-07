//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Tülay MAYUNCUR on 7.10.2023.
//

import Foundation

class WeatherModel: Codable {
    let success: Bool
    let city: String
    let result: [WeatherData]
}

class WeatherData: Codable {
    let icon: String
    let status: String
    let degree: String
    
init(icon: String, status: String, degree: String) {
    
        self.icon = icon
        self.status = status
        self.degree = degree
    }
}
