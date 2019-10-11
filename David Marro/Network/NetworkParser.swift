//
//  NetworkParser.swift
//  David Marro
//
//  Created by David Marro on 10/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class NetworkParser {
    
    static func parseMeteo(conData data:IEDDictionary) -> Meteo?{
        let meteo = Meteo()
        
        
        if let  main = data["main"] as? IEDDictionary{
            meteo.temperatura = main["temp"] as? Double
        }
        
        if let weather = data["weather"] as? IEDArray {
            if let firstWeather = weather.first{
                meteo.descrizione = firstWeather["description"]  as? String
            }
            
        }
        return meteo
    }
    
    
    
    
    static func parseUtente(conData data:IEDDictionary) -> Utente?{
      
        
            let utente = Utente()
        
        
     
            utente.email = data["email"] as? String
            utente.nome = data["nome"] as? String
            utente.cognome = data["cognome"] as? String
            utente.avatarUrl = data["avatar_url"] as? String
            utente.citta = data["citta"] as? String
             utente.dataNascita = data["data_nascita"] as? String
        
            
        
        return utente
    }


}
