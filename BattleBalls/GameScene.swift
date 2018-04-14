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
    var blueCount: SKLabelNode!
    var redCount: SKLabelNode!
    
    var bottomTouchLocation: CGPoint? = nil
    var topTouchLocation: CGPoint? = nil
    let minDistance:CGFloat = 25
    var distance: CGFloat!
    var hittable = true
    var blueVelocity: Int = 0
    var redVelocity: Int = 0
    
    
    
    
    override func didMove(to view: SKView) {
        blue = self.childNode(withName: "blue") as! SKSpriteNode
        red = self.childNode(withName: "red") as! SKSpriteNode
        blueCount = blue.childNode(withName: "blueVelocityCount") as! SKLabelNode
        redCount = red.childNode(withName: "redVelocityCount") as! SKLabelNode
        
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
        blueCount.text = "\(blueVelocity)"
        redCount.text = "\(redVelocity)"
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
            print("blue top")
            if hittable {
                if blueVelocity > redVelocity {
                    hittable = false
                    let moveUp = SKAction.moveBy(x: 0, y: 50, duration: 0.025)
                    red.run(moveUp)
                    hittable = true
                } else {
                    hittable = false
                    let moveDown = SKAction.moveBy(x: 0, y: -50, duration: 0.025)
                    blue.run(moveDown)
                    hittable = true
                }
                
            }
           
            
        } else if nodeA.name == "blueRightBorder" || nodeB.name == "blueRightBorder" {
            if hittable {
                print("blue right")
                if blueVelocity > redVelocity {
                    hittable = false
                    let moveRight = SKAction.moveBy(x: 50, y: 0, duration: 0.025)
                    red.run(moveRight)
                    hittable = true
                } else {
                    hittable = false
                    let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: 0.025)
                    blue.run(moveLeft)
                    hittable = true
                }
                
            }
            
        } else if nodeA.name == "blueBottomBorder" || nodeB.name == "blueBottomBorder" {
            print("blue bottom")
            if hittable {
                if blueVelocity > redVelocity {
                    hittable = false
                    let moveDown = SKAction.moveBy(x: 0, y: -50, duration: 0.025)
                    red.run(moveDown)
                    hittable = true
                } else {
                    hittable = false
                    let moveUp = SKAction.moveBy(x: 0, y: 50, duration: 0.025)
                    blue.run(moveUp)
                    hittable = true
                }
                
            }
            
        } else if nodeA.name == "blueLeftBorder" || nodeB.name == "blueLeftBorder" {
            print("blue left")
            if hittable {
                if blueVelocity > redVelocity {
                    hittable = false
                    let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: 0.025)
                    red.run(moveLeft)
                    hittable = true
                } else {
                    hittable = false
                    let moveRight = SKAction.moveBy(x: 50, y: 0, duration: 0.025)
                    blue.run(moveRight)
                    hittable = true
                }
                
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
     updateVelocties()
    }
   
    
    
}
