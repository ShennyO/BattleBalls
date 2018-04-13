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

class GameScene: SKScene {
    
    var blue: SKSpriteNode!
    var red: SKSpriteNode!
    
    var start:(location:CGPoint, time:TimeInterval)?
    var bottomTouchLocation: CGPoint? = nil
    var topTouchLocation: CGPoint? = nil
    let minDistance:CGFloat = 25
    let minSpeed:CGFloat = 200
    let maxSpeed:CGFloat = 6000
    var distance: CGFloat!
    
    override func didMove(to view: SKView) {
        blue = self.childNode(withName: "blue") as! SKSpriteNode
        red = self.childNode(withName: "red") as! SKSpriteNode
        distance = self.size.height - blue.size.height
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
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
     
    }
    
    func swipedRight(side: side) {
        let moveRight = SKAction.moveBy(x: self.size.width/3, y: 0, duration: 0.1)
        switch side {
        case .top:
            blue.run(moveRight)
        case .bottom:
            red.run(moveRight)
        }
    }
    
    func swipedUp(side: side) {
        let moveUp = SKAction.moveBy(x: 0, y: distance/3, duration: 0.1)
        switch side {
        case .top:
            blue.run(moveUp)
        case .bottom:
            red.run(moveUp)
        }
    }
    
    func swipedLeft(side: side) {
        let moveLeft = SKAction.moveBy(x: -self.size.width/3, y: 0, duration: 0.1)
        switch side {
        case .top:
            blue.run(moveLeft)
        case .bottom:
            red.run(moveLeft)
        }
    }
    
    func swipedDown(side: side) {
        let moveDown = SKAction.moveBy(x: 0, y: -distance/3, duration: 0.1)
        switch side {
        case .top:
            blue.run(moveDown)
        case .bottom:
            red.run(moveDown)
        }
    }
    
    
}
