//
//  Network.swift
//  David Marro
//
//  Created by David Marro on 10/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

/**

 Classe che si occupa di gestire  tutte le chiamate ai servizi web esterni dall'app.
 
 */

class Network {
//    chiedi al server il meteo di roma
    static func richiestaMeteoRoma(){
        let url = "http://ied.apptoyou.it/app/meteoroma.php"
        
        IEDNetworking.jsonGet(url: url, authToken: nil, parameters: nil) {
//            viene eseguita quando riceve  risp dal server
            (risposta) in
            if risposta.success{
//                controllo se i dati ricevuti sono del tipo che mi aspettavo
                if let temperatura = risposta.data as? Int{
                    print("La temperatura a Roma è di \(temperatura) °C")
                }
            }
        }
    }
    
    
    typealias CompletionMeteo = ((Meteo?) -> Void)
    
    static  func richiestaMeteoEvento(_ evento: Evento?, completion: CompletionMeteo?) {
//        check validità dei dati
        
        guard let coordinate =  evento?.coordinate else{
// dati non validi
           
            return
        }
        
        
//        indirizzo del servizio web da richiamare
        let url = "http://ied.apptoyou.it/app/weather.php"
//        parametri da passare  al servizio
        var parametri=IEDDictionary()
        parametri["appid"]="7854e283b3c65ba9943d850e002019b4"
        parametri["units"]="metric"
        parametri["lang"]="it"
        
        parametri["lat"] = coordinate.latitude
        parametri["lon"] = coordinate.longitude
        
//        richiamo il servizio
        
        IEDNetworking.jsonGet(url: url, authToken: nil, parameters: parametri) {
//            eseguita quando riceve risposta dal server
            (risposta) in
            if risposta.success{
                if let dictionary = risposta.data as? IEDDictionary{
//                    parse della risposta
                    let meteo = NetworkParser.parseMeteo(conData: dictionary)
                    completion?(meteo)
                    print("la temperatura  è: \(meteo?.temperatura ?? 0)")
                    print("la descrizione  è: \(meteo?.descrizione ??  "")")
                    
                }


            }
        }
    }
    
    
    
    typealias CompletionLogin = ((Utente?) -> Void)
    
    static func richiestaLogin(conEmail email: String?, password: String?, completion: CompletionLogin?){
//        controllo la validita dei dati
        guard let email = email, let password = password else {
//            Dati non validi
            completion?(nil)
            return
        }
//        indirizzo del servizio web da richiamare
        let url = "http://ied.apptoyou.it/app/login.php"
        
//        parametri da passare al servizio
        var parametri = IEDDictionary()
        parametri["email"]=email
        parametri["password"]=password
        IEDNetworking.jsonPost(url: url, authToken: nil, parameters: parametri) { (risposta) in
            if risposta.success{
//              controllo se il server ha inviato i dati che mi aspettavo
                    if let data = risposta.data as? IEDDictionary{
                        if let datiUtente = data["data"] as? IEDDictionary{
//                            login Riuscito
                            let utente = NetworkParser.parseUtente(conData: datiUtente)
                            
//                            restituisco l oggetto alla funzione chiamante
                            
                            completion?(utente)
                            
                            return
                        }
        }
    }

//                login fallito
                completion?(nil)
            
        }
    }

}
