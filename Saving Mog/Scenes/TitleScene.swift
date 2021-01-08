//
//  TitleScene.swift
//  Saving Mog
//
//  Created by Weibin Wang on 2021-01-08.
//

import UIKit
import SpriteKit

class TitleScene: SKScene {
    
    private var playButton: SKLabelNode?
    private var titleLbl : SKLabelNode?
    var background = SKSpriteNode(imageNamed: "titleBG.jpg")
    
    override func sceneDidLoad() {
        
        // Do any additional setup after loading the view, typically from a nib.
        background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        background.zPosition = -1
        addChild(background)
        self.titleLbl = self.childNode(withName: "//gameTitle") as? SKLabelNode
        titleLbl?.fontName = "Ferrum"
        self.playButton = self.childNode(withName: "//startBtn") as? SKLabelNode
        
        // Reset the high score in UserDefaults to 0
//        let defaults = UserDefaults.standard
//        defaults.set(0, forKey: "highScore")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            let tranitionAnim1 = SKAction.scale(by: 2, duration: 0.4)
                
            
            if node.name == "startBtn" {
                playButton!.run(SKAction.scale(by: 0.5, duration: 0.4))
                playButton!.run(tranitionAnim1, completion: {
                    let transitionAnim2 = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                    let gameScene = SKScene(fileNamed: "GameScene")
                    gameScene!.scaleMode = .aspectFill
                    self.view?.presentScene(gameScene!, transition: transitionAnim2)
                })
            }
        }
    }
}
