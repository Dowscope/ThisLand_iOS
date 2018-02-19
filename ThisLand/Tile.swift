//
//  Tile.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-02-06.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import SpriteKit
import GameplayKit

enum TileType {
    case WATER
    case GRASS
    case TREES
}

class Tile {
    
    let type: TileType
    let location: CGPoint
    
    // Properties of the tile
    var isHarvestable: Bool
    var isWalkable: Bool
    var isBuildable: Bool
    
    init(type: TileType, location: CGPoint) {
        self.type = type
        self.location = location
        
        switch type {
        case .GRASS:
            isWalkable = true
            isHarvestable = false
            isBuildable = true
        case .TREES:
            isWalkable = false
            isHarvestable = true
            isBuildable = false
        case .WATER:
            isWalkable = false
            isHarvestable = false
            isBuildable = false
        }
    }
    
    func getTypeString() -> String {
        switch type {
        case .GRASS:
            return "Grass"
        case .TREES:
            return "Trees"
        case .WATER:
            return "Water"
        }
    }
}
