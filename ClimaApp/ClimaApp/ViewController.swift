//
//  ViewController.swift
//  ClimaApp
//
//  Created by Mac13 on 18/03/22.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var nombreCiudadTextField: UITextField!
    @IBOutlet weak var temperaturaLbl: UILabel!
    @IBOutlet weak var mensajeTemperaturaLbl: UILabel!
    @IBOutlet weak var climaIV: UIImageView!
    
    var climaManager = ClimaManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        climaIV.image = UIImage(systemName: "cloud.fill")
        
        //locationManager.delegate = self
        
        
    }
    
    @IBAction func buscarBtn(_ sender: UIButton) {
        print("Busqueda realizada \(nombreCiudadTextField.text ?? "Morelia")")
    }
    
    @IBAction func ubicacionBtn(_ sender: UIButton) {
        print("Ubicacion obtenida")
    }
    
    //MARK: - Metodos del textfield
    //Identificar boton de teclado virtual
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nombreCiudadTextField.endEditing(true)
        return true
    }
    
    //Identifica cuando el usuario termina de editar
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("El usuario termino de editar")
        
        //llamar a API
        
        climaManager.obtenerClima(nombreCiudad: nombreCiudadTextField.text ?? "morelia")
    }
    
    //Evita que el usuario no escriba nada
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if nombreCiudadTextField.text != "" {
            return true
        } else {
            print("escribe una ciudad por favor")
            mensajeTemperaturaLbl.text = "Necesitas colocar una ciudad"
            return false
        }
    }
    
    

}

