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


class ARCameraController: UIViewController, ARSCNViewDelegate {

    
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
//        Creo manualmente la reference image da cercare nel mondo reale
        let image = UIImage.init(named: "ImmagineDEmo")!
        let referenceImage = ARReferenceImage.init(image.cgImage!, orientation: .up, physicalWidth: 0.05)
//      La aggiungo alla configurazione AR
        configuration.trackingImages = [referenceImage]
        
        sceneView.delegate  = self
        sceneView.session.run(configuration)
    }
    
    
    private func interrompiSessione(){
//        Interrompo la modalità AR
        
        sceneView.session.pause()
    }
    
// MARK: -FUNZIONI PRIVATE
    
    
// MARK: -ASRCNView delegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARImageAnchor else {
            return
        }
        
        print("Immagine trovata!")
//        Torno sul thread principale
    
        DispatchQueue.main.async {
            
            
            let scene = SCNScene.init(named: "book.scn")
            let bookNode = scene?.rootNode.childNode(withName: "book", recursively: false)
            node.addChildNode(bookNode!)
            
        }
    }


}
