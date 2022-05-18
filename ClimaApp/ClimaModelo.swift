//
//  ClimaModelo.swift
//  ClimaApp
//
//  Created by Mac13 on 24/03/22.
//

import Foundation

struct ClimaModelo {
    let condicionID: Int
    let nombreCiudad: String
    let temperatura: Double
    
    //Propiedad computada
    var temperaturaString: String{
        return String(format: "%.1f", temperatura)
    }
    var nombreCondicion: String{
        switch condicionID {
        case 200...232:
            return "cloud.bolt"
        case 300...351:
            return "cloud.bolt.fill"
        case 400...451:
            return "snow"
        case 500...551:
            return "snow"
        case 600...651:
            return "sun.max"
        case 700...751:
            return "sun.min"
        case 800:
            return "cloud"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
}
