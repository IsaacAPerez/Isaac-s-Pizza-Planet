//
//  GameScene.swift
//  Final Project
//
//  Created by Isaac Abel Perez on 4/14/20.
//  Copyright © 2020 Isaac Abel Perez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
   
    private var player : SKSpriteNode?
    private var goodUFO : SKSpriteNode?
    private var badUFO : SKSpriteNode?
    private var pizza : SKSpriteNode?
    private var healthy : SKSpriteNode?
    private var score : SKLabelNode?
    private var life1 : SKSpriteNode?
    private var life2 : SKSpriteNode?
    private var life3 : SKSpriteNode?
    var arrayOfLife : [SKSpriteNode] = []
    private var playerWalkingFrames: [SKTexture] = []
    public static var scoreNumber = 0
    private var lifeNumber = 0
    private var lifeCounter = 0
    var musicPlayer = MusicPlayer()
    var start : StartViewController?

    
    override func didMove(to view: SKView) {
        buildPlayer()
        self.score = self.childNode(withName: "score") as? SKLabelNode
        self.goodUFO = self.childNode(withName: "goodUFO") as? SKSpriteNode
        self.badUFO = self.childNode(withName: "badUFO") as? SKSpriteNode
        self.player = self.childNode(withName: "player") as? SKSpriteNode
        self.life1 = self.childNode(withName: "life1") as? SKSpriteNode
        self.life2 = self.childNode(withName: "life2") as? SKSpriteNode
        self.life3 = self.childNode(withName: "life3") as? SKSpriteNode
        moveUFOS()
        arrayOfLife.append(life1!)
        arrayOfLife.append(life2!)
        arrayOfLife.append(life3!)
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(dropFood),
                                                      SKAction.wait(forDuration: 2.0)])))
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(makeHarder),
        SKAction.wait(forDuration: 2.0)])))
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addLife),
                                                      SKAction.wait(forDuration: 2.0)])))
    }
    
    func buildPlayer() {
      let playerAnimatedAtlas = SKTextureAtlas(named: "animate")
      var walkFrames: [SKTexture] = []

      let numImages = playerAnimatedAtlas.textureNames.count
      for i in 1...numImages {
        let playerTextureName = "player\(i)"
        walkFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        
      }
      playerWalkingFrames = walkFrames
        let firstFrameTexture = playerWalkingFrames[0]
        player = SKSpriteNode(texture: firstFrameTexture)
        player?.scale(to: CGSize(width: 0.3, height: 0.3))
        player!.position = CGPoint(x: -475, y: -260)
        addChild(player!)
    }
    
    func animatePlayer() {
        player!.run(SKAction.repeatForever(
        SKAction.animate(with: playerWalkingFrames,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: false)),
        withKey:"walkingInPlacePlayer")
    }
    func addLife() {
        if GameScene.scoreNumber % 20 == 0 && GameScene.scoreNumber > 0 {
            if lifeNumber > 0 {
                arrayOfLife[lifeNumber - 1].removeFromParent()
                addChild(arrayOfLife[lifeNumber - 1])
                lifeNumber -= 1
            }
        }
    }
    
    func checkPizza() {
        
        for child in self.children {
            if child.name == "pizza" {
                if child.position.y + 200 < (player?.position.y)! {
                    if lifeNumber > arrayOfLife.count - 2 {
                        self.endGame()
                    } else if lifeCounter >= 0 {
                        arrayOfLife[lifeNumber].removeFromParent()
                                           child.removeFromParent()
                                           lifeNumber += 1
                        lifeCounter += 1
                        
                    }
                }
            }
        }
    }
    
    func endGame() {
        self.lifeNumber = 0
        if GameScene.scoreNumber > StartViewController.scoreINT {
            StartViewController.scoreINT = GameScene.scoreNumber
            start?.score.text = "High Score: " + String(GameScene.scoreNumber)
            
        }
        let endGame = EndGameScene(fileNamed: "EndGameScene")
        endGame?.scaleMode = .aspectFill
        self.scene?.view?.presentScene(endGame)
    }
    
    func moveUFOS() {
        let oscillateRight = SKAction.oscillation(amplitude: 100, timePeriod: 6, midPoint: goodUFO!.position)
        let oscillateLeft = SKAction.oscillationLeft(amplitude: 100, timePeriod: 6, midPoint: goodUFO!.position)
        goodUFO!.run(SKAction.repeatForever(SKAction.sequence([oscillateRight,oscillateLeft])))
        badUFO!.run(SKAction.repeatForever(SKAction.sequence([oscillateLeft,oscillateRight])))
        Data.actions?.append(oscillateLeft)
        Data.actions?.append(oscillateRight)
        
    }
    func dropFood() {
        self.pizza = SKSpriteNode(imageNamed: "pizza")
        self.pizza?.xScale = 0.3
        self.pizza?.yScale = 0.3
        self.pizza!.position.x = goodUFO!.position.x
        self.pizza!.position.y = goodUFO!.position.y
        self.pizza?.name = "pizza"
        self.addChild(pizza!)
        let fall = SKAction.moveTo(y: CGFloat(-800), duration: 4)
        pizza!.run(SKAction.sequence([fall, SKAction.removeFromParent()]))
        
        self.healthy = SKSpriteNode(imageNamed: "green")
        self.healthy?.xScale = 0.1
        self.healthy?.yScale = 0.1
        self.healthy?.position.x = badUFO!.position.x
        self.healthy!.position.y = badUFO!.position.y
        self.healthy?.name = "healthy"
        self.addChild(healthy!)
        let fallBad = SKAction.moveTo(y: CGFloat(-800), duration: 2)
        healthy!.run(SKAction.sequence([fallBad, SKAction.removeFromParent()]))
         
    }
    func dropFood(forGood goodUFO: SKSpriteNode) {
        self.pizza = SKSpriteNode(imageNamed: "pizza")
        self.pizza?.xScale = 0.3
        self.pizza?.yScale = 0.3
        self.pizza!.position.x = goodUFO.position.x
        self.pizza!.position.y = goodUFO.position.y
        self.pizza?.name = "pizza"
        
        self.addChild(pizza!)
        let fall = SKAction.moveTo(y: CGFloat(-800), duration: 10)
        pizza!.run(SKAction.sequence([fall, SKAction.removeFromParent()]))
    }
    func dropFood(forBad badUFO: SKSpriteNode) {
        self.healthy = SKSpriteNode(imageNamed: "green")
        self.healthy?.xScale = 0.1
        self.healthy?.yScale = 0.1
        self.healthy?.position.x = badUFO.position.x
        self.healthy!.position.y = badUFO.position.y
        self.healthy?.name = "healthy"
        self.addChild(healthy!)
        let fallBad = SKAction.moveTo(y: CGFloat(-800), duration: 3)
        healthy!.run(SKAction.sequence([fallBad, SKAction.removeFromParent()]))
    }
    
    func movePlayer (moveBy: CGFloat, forTheKey: String) {
        animatePlayer()
        let moveAction = SKAction.moveBy(x: moveBy, y: 0, duration: 1)
        let repeatForEver = SKAction.repeatForever(moveAction)
        player!.run(repeatForEver, withKey: forTheKey)
    }
    
    
    func updateScore() {
        musicPlayer.bitSound()
        GameScene.scoreNumber += 1
        self.score?.text = "Score:" + String(GameScene.scoreNumber)
        
    }
    
    func makeHarder() {
        let moreGood = SKSpriteNode(imageNamed: "goodUFO")
        let moreBad = SKSpriteNode(imageNamed: "badUFO")
        if GameScene.scoreNumber % 4 == 0 && GameScene.scoreNumber > 0 {
            moreGood.xScale = 0.3
            moreGood.yScale = 0.3
            moreGood.position = CGPoint(x: -1200, y: 400)
            addChild(moreGood)
            let oscillateRight = SKAction.oscillation(amplitude: 100, timePeriod: 10, midPoint: moreGood.position)
            moreGood.run(oscillateRight)
            run(SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 2.0), SKAction.run {
                self.dropFood(forGood: moreGood)
                }]), count: 2))
            
        }
        if GameScene.scoreNumber % 7 == 0 && GameScene.scoreNumber > 0 {
            moreBad.xScale = 0.3
            moreBad.yScale = 0.3
            moreBad.position = CGPoint(x: -1200, y: 400)
            addChild(moreBad)
            let oscillateRight = SKAction.oscillation(amplitude: 100, timePeriod: 10, midPoint: moreBad.position)
            moreBad.run(oscillateRight)
            run(SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 2.0), SKAction.run {
                self.dropFood(forBad: moreBad)
                }]), count: 2))
            
        }
        
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       for touch in (touches) {
        let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name {
                if name == "left" {
                    //move to left
                    player!.xScale = abs(player!.xScale) * 1.0
                    movePlayer(moveBy: -800, forTheKey: "left")
                   
                }
                if name == "right" {
                    //move to right
                    player!.xScale = abs(player!.xScale) * -1.0
                    movePlayer(moveBy: 800, forTheKey: "right")
                    
                }
            }
        
        }
    }
    

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name {
                if name == "paused" {
                    if self.isPaused {
                        MusicPlayer.shared.tapSound()
                        self.isPaused = false
                    } else {
                    
                    self.isPaused = true
                    }
                
                }
                if name == "restart" {
                    MusicPlayer.shared.tapSound()
                    MusicPlayer.shared.stopGame()
                    MusicPlayer.shared.gameSound()
                    
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill

                    self.scene?.view?.presentScene(gameScene!, transition:
                        SKTransition.doorsCloseHorizontal(withDuration: 0.4))
                
            }
            if name == "home" {
                MusicPlayer.shared.tapSound()
                MusicPlayer.shared.stopGame()
                self.lifeNumber = 0
                self.view?.window?.rootViewController?.dismiss(animated: true, completion: nil)
                MusicPlayer.shared.startBackgroundMusic()
            }
                player?.zPosition = 5
                player!.removeAllActions()
        
        }
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
       
    
        checkPizza()
        for child in self.children {
            if child.name == "pizza" {
                if child.intersects(player!) {
                    print("collide")
                    updateScore()
                    child.removeFromParent()
                }
            }
            if child.name == "healthy" {
                if child.intersects(player!) {
                    endGame()
                    child.removeFromParent()
                }
            }
    
        }
    }
    
}
