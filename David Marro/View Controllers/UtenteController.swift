//
//  UtenteController.swift
//  David Marro
//
//  Created by David Marro on 24/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class UtenteController: UIViewController {

    @IBOutlet weak var fotoProfilo: UIImageView!
    
    @IBOutlet weak var labelCitta: UILabel!
    @IBOutlet weak var labelNascita: UILabel!
    @IBOutlet weak var labelCognome: UILabel!
    @IBOutlet weak var labelNome: UILabel!
    override func viewDidLoad() {
        
        labelNome.text =  LoginUtility.utenteConnesso?.nome
        NetworkUtility.downloadImmagine(indirizzoWeb: LoginUtility.utenteConnesso?.avatarUrl, perImageView: fotoProfilo)
        labelCognome.text = LoginUtility.utenteConnesso?.cognome
        labelCitta.text = LoginUtility.utenteConnesso?.citta
        labelNascita.text = LoginUtility.utenteConnesso?.dataNascita
        
        fotoProfilo.layer.cornerRadius = 60.0
        fotoProfilo.clipsToBounds = true

        
    }

    
}
