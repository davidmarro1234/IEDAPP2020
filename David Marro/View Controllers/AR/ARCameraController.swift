//
//  ARCameraController.swift
//  David Marro
//
//  Created by David Marro on 02/12/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit
import ARKit
import SceneKit


class ARCameraController: UIViewController {

    
    @IBOutlet weak var sceneView: ARSCNView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avviaSessione()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interrompiSessione()
    }
    
    
    
    
// MARK: -SETUP
    
    private func avviaSessione(){
//        Avvio modalità AR
        let configuration = ARImageTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    
    private func interrompiSessione(){
//        Interrompo la modalità AR
        
        sceneView.session.pause()
    }
    
// MARK: -FUNZIONI PRIVATE
    


}
