//
//  ClimaManager.swift
//  ClimaApp
//
//  Created by Mac13 on 23/03/22.
//

import Foundation

protocol ClimaManagerDelegado {
    func actualizarClima(objClima: ClimaModelo)
    func huboError(cualError: Error)
}

struct ClimaManager {
    let climaURL = "https://api.openweathermap.org/data/2.5/weather?lat=19.7320897&lon=101.2064935&appid=ccebb8ffcbeebc2e868cd7e5a0dd192c"
    
    var delegado: ClimaManagerDelegado?
    
    func obtenerClima(nombreCiudad: String) {
        let urlstring = "\(climaURL)&q=\(nombreCiudad)"
        print(urlstring)
        realizarSolicitud(urlString: urlstring)
    }
    
    func realizarSolicitud(urlString: String){
        
        //1.- Crear url
        if let url = URL(string: urlString){
            
            //2.- Crear urlsession
            let session = URLSession(configuration: .default)
            
            //3.- Asignar una tarea a la sesion
            //let tarea = session.dataTask(with: url, completionHandler: controladorFinalizacion(datos:respuesta:error:))
            let tarea = session.dataTask(with: url) { datos, respuesta, error in
                if error != nil {
                    print(error?.localizedDescription ?? "Error al consumir api")
                }
                
                if let datosSeguros = datos {
                    if let objClima = analizarJSON(datosClima: datosSeguros){
                        delegado?.actualizarClima(objClima: objClima)
                    }
                    //analizarJSON(datosClima: datosSeguros)
                }
            }
            
            //4.- Comenzar la tarea
            tarea.resume()
        }
        
    }
    
    func analizarJSON(datosClima: Data) -> ClimaModelo?{
        let decodificador = JSONDecoder()
        do{
        let datosDecodificados = try decodificador.decode(DatosClima.self, from: datosClima)
            //print(datosDecodificados.name)
            //print(datosDecodificados.main.temp)
            //print(datosDecodificados.weather[0].id)
        let condicionID = datosDecodificados.weather[0].id
        let nombreCiudad = datosDecodificados.name
        let temperatura = datosDecodificados.main.temp
        let objClima = ClimaModelo(condicionID: condicionID, nombreCiudad: nombreCiudad, temperatura: temperatura)
            
            var objClimaModelo = ClimaModelo(condicionID: condicionID, nombreCiudad: nombreCiudad, temperatura: temperatura)
        } catch {
            print(error)
        }
        return nil
    }
    
    func controladorFinalizacion(datos: Data?, respuesta: URLResponse?, error: Error?){
        if error != nil {
            print(error?.localizedDescription ?? "Error al consumir api")
            return
        }
        
        //si no hya errores
        if let datosSeguros = datos {
            let datosString = String(data: datosSeguros, encoding: .utf8)
            print(datosString ?? "No hubo datos en la API")
        }
    }
}
