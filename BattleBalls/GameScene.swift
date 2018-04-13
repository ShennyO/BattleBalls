//
//  GameScene.swift
//  BattleBalls
//
//  Created by Sunny Ouyang on 4/12/18.
//  Copyright © 2018 Sunny Ouyang. All rights reserved.
//

import SpriteKit
import GameplayKit

enum side {
    case top
    case bottom
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var blue: SKSpriteNode!
    var red: SKSpriteNode!
    
    var bottomTouchLocation: CGPoint? = nil
    var topTouchLocation: CGPoint? = nil
    let minDistance:CGFloat = 25
    var distance: CGFloat!
    var hittable = true
    var blueVelocity: CGFloat = 0
    var redVelocity: CGFloat = 0
    
    
    
    override func didMove(to view: SKView) {
        blue = self.childNode(withName: "blue") as! SKSpriteNode
        red = self.childNode(withName: "red") as! SKSpriteNode
        distance = self.size.height - blue.size.height
        physicsWorld.contactDelegate = self
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self.view)
            if location.y < (self.view?.frame.midY)! {
                topTouchLocation = location
            } else {
                bottomTouchLocation = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self.view)
            if bottomTouchLocation != nil && location.y > (self.view?.frame.midY)! {
                calculateSwipe(side: .bottom, firstTouch: bottomTouchLocation!, lastTouch: location)
                bottomTouchLocation = nil
            }
            else if topTouchLocation != nil && location.y < (self.view?.frame.midY)! {
                calculateSwipe(side: .top, firstTouch: topTouchLocation!, lastTouch: location)
                topTouchLocation = nil
            }
        }
    }
    
    func updateVelocties() {
        if blueVelocity > 3 {
            blueVelocity = 0
        }
        if redVelocity > 3 {
            redVelocity = 0
        }
    }
    
    
    func calculateSwipe(side: side, firstTouch: CGPoint, lastTouch: CGPoint) {
        //        print("Calculating swipe on the \(side) side with location1: \(firstTouch) and location2: \(lastTouch)")
        let yChange = lastTouch.y - firstTouch.y
        let xChange = lastTouch.x - firstTouch.x
        if abs(xChange) > abs(yChange) {
            if xChange <= -20 {
               swipedLeft(side: side)
            } else if xChange >= 20 {
               swipedRight(side: side)
            }
        } else {
            if yChange >= 20 {
               swipedDown(side: side)
            } else if yChange <= -20 {
                swipedUp(side: side)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        /* Get references to bodies involved in collision */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        /* Did our hero pass through the 'goal'? */
        if nodeA.name == "blueTopBorder" || nodeB.name == "blueTopBorder" {
            if hittable {
                print("Blue top collided")
                hittable = false
                let moveDown = SKAction.moveBy(x: 0, y: -50, duration: 0.025)
                blue.run(moveDown)
                hittable = true
            }
           
            
        } else if nodeA.name == "blueRightBorder" || nodeB.name == "blueRightBorder" {
            if hittable {
            print("Blue Right collided")
                hittable = false
                let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: 0.025)
                blue.run(moveLeft)
                hittable = true
            }
            
        } else if nodeA.name == "blueBottomBorder" || nodeB.name == "blueBottomBorder" {
            if hittable {
            print("Blue Bottom collided")
                hittable = false
                let moveUp = SKAction.moveBy(x: 0, y: 50, duration: 0.025)
                blue.run(moveUp)
                hittable = true
            }
            
        } else if nodeA.name == "blueLeftBorder" || nodeB.name == "blueLeftBorder" {
            if hittable {
            print("Blue left collided")
                hittable = false
                let moveRight = SKAction.moveBy(x: 50, y: 0, duration: 0.025)
                blue.run(moveRight)
                hittable = true
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
     
    }
   
    
    
}
