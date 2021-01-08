//
//  GameScene.swift
//  Saving Mog
//
//  Created by Weibin Wang on 2021-01-07.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
    static let Cactuar : UInt32 = 0b1
    static let Mog : UInt32 = 0b1
    static let MainChara : UInt32 = 0b10
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
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
        
        physicsWorld.gravity = CGVector(dx :0, dy: 0)
        physicsWorld.contactDelegate = self;
        
        sportNode?.physicsBody = SKPhysicsBody(circleOfRadius: (sportNode?.size.width)!/2)
        sportNode?.physicsBody?.isDynamic = true
        sportNode?.physicsBody?.categoryBitMask = PhysicsCategory.MainChara
        sportNode?.physicsBody?.contactTestBitMask = PhysicsCategory.Cactuar
        sportNode?.physicsBody?.collisionBitMask = PhysicsCategory.None
        sportNode?.physicsBody?.usesPreciseCollisionDetection = true
        
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
        cactuar.physicsBody = SKPhysicsBody(rectangleOf: cactuar.size)
        cactuar.physicsBody?.isDynamic = true;
        cactuar.physicsBody?.categoryBitMask = PhysicsCategory.Cactuar
        cactuar.physicsBody?.contactTestBitMask = PhysicsCategory.MainChara
        cactuar.physicsBody?.collisionBitMask = PhysicsCategory.None
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
        mog.physicsBody = SKPhysicsBody(rectangleOf: mog.size)
        mog.physicsBody?.isDynamic = true;
        mog.physicsBody?.categoryBitMask = PhysicsCategory.Mog
        mog.physicsBody?.contactTestBitMask = PhysicsCategory.MainChara
        mog.physicsBody?.collisionBitMask = PhysicsCategory.None
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -mog.size.height/2), duration: TimeInterval (actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        mog.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func moveMainChara(toPoint pos : CGPoint) {
        let actionMove = SKAction.moveTo(x: pos.x, duration: TimeInterval(0.1))
        sportNode?.run(SKAction.sequence([actionMove]))
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
        moveMainChara(toPoint: pos)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
        moveMainChara(toPoint: pos)
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
