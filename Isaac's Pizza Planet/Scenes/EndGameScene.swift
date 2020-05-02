//
//  EndGameScene.swift
//  Isaac's Pizza Planet
//
//  Created by Isaac Abel Perez on 4/27/20.
//  Copyright © 2020 Isaac Abel Perez. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class EndGameScene: SKScene {
    public var label : SKLabelNode?
    public var start : StartViewController?
    public var musicPlayer = MusicPlayer()
    

    
    override func didMove(to view: SKView) {
        self.label = (self.childNode(withName: "myScore") as! SKLabelNode)
        self.label?.text = String(GameScene.scoreNumber)
        StartViewController.scoreINT = GameScene.scoreNumber
        GameScene.scoreNumber = 0
        
    
    }
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
        let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name {
                if name == "restartGame" {
                    MusicPlayer.shared.stopGame()
                    MusicPlayer.shared.gameSound()
                    MusicPlayer.shared.tapSound()
                    let gameScene = GameScene(fileNamed: "GameScene")
                    gameScene?.scaleMode = .aspectFill
                    self.scene?.view?.presentScene(gameScene)
                    
                }
                if name == "backHome" {
                    MusicPlayer.shared.tapSound()
                    MusicPlayer.shared.stopGame()
                    MusicPlayer.shared.startBackgroundMusic()
                    self.view?.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
