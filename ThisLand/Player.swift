//
//  Player.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-02-19.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import SpriteKit
import GameplayKit

enum EntityType {
    case WORKER
}

class Player: SKNode {
    var entities = [GKEntity]()
    
    func addEntity(location: CGPoint, type: EntityType, avoidNodes: [SKNode]){
        switch type {
        case .WORKER:
            print(avoidNodes)
            let w = Worker(position: location, jobPosition: JOB_TITLE.GENERAL, avoidNodes: avoidNodes)
            
            if let sprite = w.component(ofType: SpriteComponent.self)?.sprite {
                addChild(sprite)
            }
            
            entities.append(w)
        }
    }
    
    func update(dt: TimeInterval) {
        for e in entities {
            e.update(deltaTime: dt)
        }
    }
}
