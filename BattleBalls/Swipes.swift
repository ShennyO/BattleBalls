//
//  Swipes.swift
//  BattleBalls
//
//  Created by Sunny Ouyang on 4/12/18.
//  Copyright © 2018 Sunny Ouyang. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    
    func swipedRight(side: side) {
        let moveRight = SKAction.moveBy(x: self.size.width/3, y: 0, duration: 0.150)
        switch side {
        case .top:
            blueVelocity += 1
            blue.run(moveRight)
        case .bottom:
            redVelocity += 1
            red.run(moveRight)
        }
    
        
    }
    
    func swipedUp(side: side) {
        
        let moveUp = SKAction.moveBy(x: 0, y: distance/3, duration: 0.225)
        switch side {
        case .top:
            blueVelocity += 1
            blue.run(moveUp)
        case .bottom:
            redVelocity += 1
            red.run(moveUp)
        }
    
    
    }

    
    func swipedLeft(side: side) {
        
        let moveLeft = SKAction.moveBy(x: -self.size.width/3, y: 0, duration: 0.150)
        switch side {
        case .top:
            blueVelocity += 1
            blue.run(moveLeft)
        case .bottom:
            redVelocity += 1
            red.run(moveLeft)
        }
        
        
    }
    
    func swipedDown(side: side) {
        
        let moveDown = SKAction.moveBy(x: 0, y: -distance/3, duration: 0.225)
        switch side {
        case .top:
            blueVelocity += 1
            blue.run(moveDown)
        case .bottom:
            redVelocity += 1
            red.run(moveDown)
        }
    
    }
}
