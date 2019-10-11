//
//  Utente.swift
//  David Marro
//
//  Created by David Marro on 08/04/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

// classe che definisce le proprietà e le azioni dell'entità "Utente" dentro la nostra App.

class Utente: NSObject {
    
    var id: Int?
    
    var nome: String?
    var cognome: String?
    
    var email: String?
    var password: String?
    var dataNascita: String?
    var avatarUrl: String?
    var citta: String?
}
