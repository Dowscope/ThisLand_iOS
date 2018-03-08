//
//  MoveComponent.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-03-07.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import GameplayKit

class MoveComponent: GKAgent2D, GKAgentDelegate {
    
    var avoidNodes = [GKObstacle]()
    
    init(maxSpeed: Float, maxAcc: Float, radius: Float, avoid: [SKNode]) {
        super.init()
        
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcc
        self.radius = radius
        self.mass = 10
        delegate = self
        
        avoidNodes = SKNode.obstacles(fromSpriteTextures: avoid, accuracy: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        position = (entity?.component(ofType: SpriteComponent.self)?.sprite.position.toFloat2)!
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        if let sprite = entity?.component(ofType: SpriteComponent.self)?.sprite {
            sprite.position = position.toCGPoint
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        behavior = MoveBehaviour(maxSpeed: self.maxSpeed, avoid: avoidNodes)
    }
}

extension CGPoint {
    var toFloat2: float2 {
        return float2(x: Float(self.x), y: Float(self.y))
    }
}

extension float2 {
    var toCGPoint: CGPoint {
        return CGPoint(x: CGFloat(self.x), y: CGFloat(self.y))
    }
}
