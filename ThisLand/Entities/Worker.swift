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
    
    init(position: CGPoint){
        super.init()
        
        addComponent(SpriteComponent(position, "Worker_Down_Stand"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
