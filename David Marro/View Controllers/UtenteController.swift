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
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
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

    
    
    @IBAction func logoutPressed(_ sender: Any) {
        AlertUtility.mostraAlertDiConferma(conTitolo: "Logout", messaggio: "Sei sicuro di voler uscire?", viewController: self) { (sceltaUtente) in
                   if sceltaUtente {
                   
                       LoginUtility.utenteConnesso = nil
                    LoginUtility.salva()
//                    self.dismiss(animated: true)
                    self.tornaAllaLogin()
                   }
    }
    
 
    
}
    
    private func tornaAllaLogin(){
//        ricreo il view controller iniziale
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        
        present(viewController,animated: true)
    }
    
}
