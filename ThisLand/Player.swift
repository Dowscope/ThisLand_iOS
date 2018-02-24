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
    
    func addEntity(location: CGPoint, type: EntityType){
        switch type {
        case .WORKER:
            let w = Worker(position: location)
            if let sprite = w.component(ofType: SpriteComponent.self)?.sprite {
                addChild(sprite)
                print(sprite.position)
            }
            
            
            entities.append(w)
        }
    }
}
