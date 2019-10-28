//
//  UtenteController.swift
//  David Marro
//
//  Created by David Marro on 24/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class UtenteController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {


    @IBOutlet weak var fotoProfilo: UIImageView!
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    @IBOutlet weak var labelCitta: UILabel!
    @IBOutlet weak var labelNascita: UILabel!
    @IBOutlet weak var labelCognome: UILabel!
    @IBOutlet weak var labelNome: UILabel!
    
    
    override func viewDidLoad() {
        UIUtility.arrotondaAngoliCerchio(fotoProfilo)
        labelNome.text =  LoginUtility.utenteConnesso?.nome
        
        NetworkUtility.downloadImmagine(indirizzoWeb: LoginUtility.utenteConnesso?.avatarUrl, perImageView: fotoProfilo)
        
        labelCognome.text = LoginUtility.utenteConnesso?.cognome
        labelCitta.text = LoginUtility.utenteConnesso?.citta
        labelNascita.text = LoginUtility.utenteConnesso?.dataNascita
        
//        fotoProfilo.layer.cornerRadius = 60.0
//        fotoProfilo.clipsToBounds = true

        
    }

    @IBAction func buttonModificaAvatar(_ sender: Any) {
//          Chiedo Conferma - Creo l'action Sheet
        let actionSheet = UIAlertController.init(title: "Modifica avatar", message: "Da dove vuoi caricare l'avatar?", preferredStyle: .actionSheet)
//  Creo l'azione del tasto fotocamera
        let actionFotocamera = UIAlertAction.init(title: "Fotocamera", style: .default) { (action) in
            
//            l'utente ha scelto la fotocamera
            self.caricaAvatarDaFotocamera()
            
            
            
            
            
        }
        
        actionSheet.addAction(actionFotocamera)
//        creo l'azione del tasto galleria
        let actionGalleria = UIAlertAction.init(title: "Galleria", style: .default) { (action) in
            self.caricaAvatarDaGalleria()
        }
//        aggiongo l'azione dell'action sheet
//        creo l'azione del tasto annulla
        
        let actionAnnulla = UIAlertAction(title: "Annulla", style: .cancel)
        actionSheet.addAction(actionGalleria)
        actionSheet.addAction(actionAnnulla)
        present(actionSheet,animated: true)
        
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
    
    
    
    
//    MARK:- Funzioni Private
    
    
    private func tornaAllaLogin(){
//        ricreo il view controller iniziale
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        
        present(viewController,animated: true)
    }

        private func caricaAvatarDaFotocamera(){
//            Bisogna inserire sul file info.plist
            
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
    //            Creo il controller della fotocamera
                let controller = UIImagePickerController()
                controller.sourceType = .camera
                controller.delegate = self
                present(controller,animated: true)
                
            }
        }
    
    private func caricaAvatarDaGalleria(){
//            Bisogna inserire sul file info.plist
            
    //            Creo il controller della fotocamera
                let controller = UIImagePickerController()
                controller.sourceType = .photoLibrary
        controller.delegate=self
                present(controller,animated: true)
                
            
        
    }
    
//    MARK- UIImagePickerCOntroller delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let immagineSelezionata = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            Ok,abbiamo l'immagine scelta o scattata dall'utente
            fotoProfilo.image = immagineSelezionata
            
//            la invio al server
            Network.richiestaModificaAvatarUtenteConnesso(nuovoAvatar: immagineSelezionata, completion: nil  )
                
            
        
        
    }

}
}
