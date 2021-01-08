//
//  GameResult.swift
//  Saving Mog
//
//  Created by Weibin Wang on 2021-01-08.
//

import UIKit
import SpriteKit

class GameResult: SKScene {
    
    let resultMsg = SKLabelNode(fontNamed: "Ferrum")
    let btnReset = SKLabelNode(fontNamed: "Ferrum")
    let btnTitle = SKLabelNode(fontNamed: "Ferrum")
    let lblHighScore = SKLabelNode(fontNamed: "Ferrum")
    let playerScore = SKLabelNode(fontNamed: "Ferrum")
    
    let newHighScoreMsg = SKLabelNode(fontNamed: "Ferrum")
    override func sceneDidLoad() {
        
        labelAttribute(lbl: resultMsg, fSize: 80, fColor: SKColor.white, fPosition: CGPoint(x: frame.midX, y: frame.height/1.5))
        labelAttribute(lbl: playerScore, fSize: 40, fColor: SKColor.white, fPosition: CGPoint(x: frame.midX, y: frame.height/1.75))
        buttonAttribute(btn: btnReset, btnText: "Reset", btnName: "ResetBtn", btnPosition: CGPoint(x: frame.midX/2, y: frame.height/2.75), btnColor: SKColor.white)
        buttonAttribute(btn: btnTitle, btnText: "Back to Title", btnName: "BackToTitle", btnPosition: CGPoint(x: frame.midX/0.75, y: frame.height/2.75), btnColor: SKColor.white)
        
        
        labelAttribute(lbl: lblHighScore, fSize: 40, fColor: SKColor.white, fPosition: CGPoint(x: frame.midX, y: frame.height/1.90))
        
        
        
        labelAttribute(lbl: newHighScoreMsg, fSize: 80, fColor: SKColor.white, fPosition: CGPoint(x: frame.midX, y: frame.height/2.35))
        newHighScoreMsg.text = "NEW HIGH SCORE!! "
        
    }
    
    func labelAttribute(lbl: SKLabelNode, fSize: CGFloat, fColor: SKColor, fPosition: CGPoint ) {
        lbl.fontSize = fSize
        lbl.fontColor = fColor
        lbl.position = fPosition
    }
    
    func buttonAttribute(btn: SKLabelNode, btnText: String, btnName: String, btnPosition: CGPoint, btnColor: SKColor) {
        btn.text = btnText
        btn.name = btnName
        btn.position = btnPosition
        btn.color = btnColor
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transitionAnim = SKAction.scale(by: 2, duration: 0.5)
        
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            
            if node.name == "ResetBtn" {
                let gameSceneTemp = GameScene(fileNamed: "GameScene")
                gameSceneTemp?.scaleMode = self.scaleMode
                btnReset.run(SKAction.scale(by: 0.5, duration: 0.5))
                btnReset.run(transitionAnim, completion: {
                    self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.reveal(with: .up, duration: 1))
                })
                
                
                
                
            }
            else if node.name == "BackToTitle" {
                let titleScene = TitleScene(fileNamed: "TitleScene")
                titleScene?.scaleMode = self.scaleMode
                btnTitle.run(SKAction.scale(by: 0.5, duration: 0.5))
                btnTitle.run(transitionAnim, completion: {
                    self.scene?.view?.presentScene(titleScene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1.0))
                })
            }
        }
    }
}
