//
//  PauseScene.swift
//  Isaac's Pizza Planet
//
//  Created by Isaac Abel Perez on 4/28/20.
//  Copyright © 2020 Isaac Abel Perez. All rights reserved.
//

import UIKit
import SpriteKit

class PauseScene: SKScene {
    
    
    private var restartLabel: SKLabelNode?
    private var resumeLabel: SKLabelNode?
    private var mainLabel: SKLabelNode?
    var musicPlayer = MusicPlayer()
    
    
    
    
     override func didMove(to view: SKView) {
        self.restartLabel = self.childNode(withName: "restart") as? SKLabelNode
        self.resumeLabel = self.childNode(withName: "resume") as? SKLabelNode
        self.mainLabel = self.childNode(withName: "backHome") as? SKLabelNode
            
        
        }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        }
            

        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        }
            
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in (touches) {
            let positionInScene = touch.location(in: self)
                let touchedNode = self.atPoint(positionInScene)
                if let name = touchedNode.name {
                    if name == "restart" {
                        let gameScene = GameScene(fileNamed: "GameScene")
                        gameScene?.scaleMode = .aspectFill
                        gameScene?.isPaused = false
                        self.scene?.view?.presentScene(gameScene)
                        
                    }
                    if name == "backHome" {
                        musicPlayer.startBackgroundMusic()
                        self.view?.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    }
                    if name == "resume" {
                        self.scene?.view?.presentScene(Data.gameScene)
                        
                        
                        

                        
                    }
                }
            
            }
        }
            
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        }
            
            
        override func update(_ currentTime: TimeInterval) {
                // Called before each frame is rendered
            
        }

}
