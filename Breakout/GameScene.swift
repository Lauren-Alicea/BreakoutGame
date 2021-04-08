//
//  GameScene.swift
//  Breakout
//
//  Created by A.M. Student on 4/6/21.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ball:SKSpriteNode!
    var paddle:SKSpriteNode!
    var scoreLabel:SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score:\(score)"
        }
    }
    
    var audioPlayer = AVAudioPlayer()
    
    // Tells you when the scene is presented by a view.
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "Ball") as? SKSpriteNode
        paddle = self.childNode(withName: "Paddle") as? SKSpriteNode
        scoreLabel = self.childNode(withName: "Score") as? SKLabelNode
        
        let sound = Bundle.main.path(forResource: "brick", ofType: "wav")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 45, dy: 45))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "Ball" && bodyBName == "Brick" || bodyAName == "Brick" && bodyBName == "Ball" {
            if bodyAName == "Brick" {
                audioPlayer.play()
                contact.bodyA.node?.removeFromParent()
                score += 1
            } else if bodyBName == "Brick" {
                audioPlayer.play()
                contact.bodyB.node?.removeFromParent()
                score += 1
            }
        }
    }
    
    // Tells us who wins or loses.
    override func update(_ currentTime: TimeInterval) {
        if (score == 12) {
            scoreLabel.text = "You Won!"
            self.view?.isPaused = true
        }
        if (ball.position.y < paddle.position.y) {
            scoreLabel.text = "You Lost!"
            self.view?.isPaused = true
        }
    }
}
