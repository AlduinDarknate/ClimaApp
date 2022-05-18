//
//  DatosClima.swift
//  ClimaApp
//
//  Created by Mac13 on 24/03/22.
//

import Foundation

struct  DatosClima: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let feelslike: Double
    let humidity: Int
}

struct Weather: Decodable {
    let id: Int
}
