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
        
        sprite = SKSpriteNode(imageNamed: imageName)
        sprite.position = tmp
        sprite.zPosition = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
