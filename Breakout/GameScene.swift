//
//  GameScene.swift
//  Breakout
//
//  Created by A.M. Student on 4/6/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var ball:SKSpriteNode!
    var paddle:SKSpriteNode!
    
    // Tells you when the scene is presented by a view.
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "Ball") as? SKSpriteNode
        paddle = self.childNode(withName: "Paddle") as? SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
    }
    
    // Tells an object that one or more new touches occured.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // Allows you to move the paddle.
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    // Tells us who wins or loses.
    override func update(_ currentTime: TimeInterval) {
        
    }
}
