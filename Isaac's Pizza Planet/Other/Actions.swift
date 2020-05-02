//
//  Actions.swift
//  Isaac's Pizza Planet
//
//  Created by Isaac Abel Perez on 4/18/20.
//  Copyright © 2020 Isaac Abel Perez. All rights reserved.
//

import Foundation
import SpriteKit


let π = CGFloat(Double.pi)
extension SKAction {
    
    static func oscillation(amplitude a: CGFloat, timePeriod t: CGFloat, midPoint: CGPoint) -> SKAction {
        let action = SKAction.customAction(withDuration: Double(t)) { node, currentTime in
            let displacement = a * sin(2 * π * currentTime / t)
            node.position.y = midPoint.y + displacement
            node.position.x += 5
        }

        return action
    }
    static func oscillationLeft(amplitude a: CGFloat, timePeriod t: CGFloat, midPoint: CGPoint) -> SKAction {
        let action = SKAction.customAction(withDuration: Double(t)) { node, currentTime in
            let displacement = a * sin(2 * π * currentTime / t)
            node.position.y = midPoint.y - displacement
            node.position.x -= 5
        }

        return action
    }
}
