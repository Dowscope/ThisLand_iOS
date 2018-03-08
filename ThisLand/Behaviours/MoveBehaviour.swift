//
//  MoveBehaviour.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-03-07.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import GameplayKit

class MoveBehaviour: GKBehavior {

    init(maxSpeed: Float, avoid: [GKObstacle]) {
        super.init()
        
        setWeight(0.1, for: GKGoal(toWander: 0.01))
        setWeight(0.5, for: GKGoal(toAvoid: avoid, maxPredictionTime: 100.0))
    }
}
