//
//  GameScene.swift
//  Saving Mog
//
//  Created by Weibin Wang on 2021-01-07.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var background = SKSpriteNode(imageNamed: "ff.jpg")
    private var sportNode : SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        background.scale(to: self.size.self)
        background.alpha = 0.2
        addChild(background)
        
        
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        sportNode = SKSpriteNode(imageNamed: "cloud.png")
        sportNode?.position = CGPoint(x: 100, y: 100)
        addChild(sportNode!)
        
        
        let counter = 4
        let runAddCactuar = SKAction.run(addCactuar)
        let runAddMog = SKAction.run(addMog)
        
        let repeatAddCactuar = SKAction.repeat(SKAction.sequence([runAddCactuar, SKAction.wait(forDuration: 0.5)]), count: counter)
        
        
        run(SKAction.repeatForever(SKAction.sequence([repeatAddCactuar, runAddMog])))
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max-min) + min
    }
    
    func addCactuar() {
        let cactuar = SKSpriteNode(imageNamed: "cactuar.png")
        cactuar.name = "DangerousChara"
        let actualX = random(min: cactuar.size.width/2, max: size.width - cactuar.size.width/2)
        cactuar.position = CGPoint (x: actualX, y: size.height + cactuar.size.height/2)
        addChild(cactuar)

        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -cactuar.size.height/2), duration: TimeInterval (actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        cactuar.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func addMog() {
        let mog = SKSpriteNode(imageNamed: "mog.png")

        mog.name = "SafeChara"
        let actualX = random(min: mog.size.width/2, max: size.width - mog.size.width/2)
        mog.position = CGPoint (x: actualX, y: size.height + mog.size.height/2)
        addChild(mog)

        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -mog.size.height/2), duration: TimeInterval (actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        mog.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
