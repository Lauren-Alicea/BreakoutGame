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
    
    // Tells an object that one or more new touches occured. This will tell my paddle where to go based on my finger.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    
    // This will allow the paddle to move without jumping around in the screen.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    
    // Tells us who wins or loses.
    override func update(_ currentTime: TimeInterval) {
        
    }
}
