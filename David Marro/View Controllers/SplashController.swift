//
//  SplashController.swift
//  David Marro
//
//  Created by David Marro on 08/04/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class SplashController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Network.richiestaMeteoRoma()
        
//        popolo il database
        Database.creaEventiDiProva()

        // Do any additional setup after loading the view.
        
        //controllare se c'è un utente connesso
        
        if LoginUtility.utenteConnesso == nil{
            // nessun utente connesso
            // vado alla pagina di Login
            
            performSegue(withIdentifier: "vaiAlLogin", sender: self)
            
        }
        else{
            // utente connesso
//            vado alla pagina home
            performSegue(withIdentifier: "VaiAllaHome", sender: self)
            
            
        }
        
        
        
    }
    


}
