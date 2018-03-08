//
//  SpriteComponent.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-02-20.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import GameplayKit

class SpriteComponent: GKComponent {
    
    var sprite: SKSpriteNode!
    
    init(_ position: CGPoint, _ imageName: String){
        super.init()
        
        var tmp = position
        
        tmp.x = floor(position.x)
        tmp.y = floor(position.y)
        
        if tmp.x < 0 {
            tmp.x += 64
        }
        
        if tmp.y < 0 {
            tmp.y += 64
        }
        
        sprite = SKSpriteNode(imageNamed: imageName)
        sprite.position = tmp
        sprite.zPosition = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
