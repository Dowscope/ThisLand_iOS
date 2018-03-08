//
//  Worker.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-02-19.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import SpriteKit
import GameplayKit

class Worker: GKEntity {
    
    init(position: CGPoint, jobPosition: JOB_TITLE, avoidNodes: [SKNode]){
        super.init()
        
        addComponent(SpriteComponent(position, "Worker_Down_Stand"))
        addComponent(JobComponent(type: jobPosition))
        addComponent(MoveComponent(maxSpeed: 0.0001, maxAcc: 0.0001, radius: 100, avoid: avoidNodes))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for c in components {
            c.update(deltaTime: seconds)
        }
    }
}
