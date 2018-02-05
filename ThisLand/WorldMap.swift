//
//  World.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-01-30.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import SpriteKit
import GameplayKit



class WorldMap: SKNode {
    let numberOfGeneratedChunks = 1
    let numberOfTilesScreenWidth = 10
    let numberOfTilesScreenHeight = 10
    
    var seed: UInt32 = 0
    var chunks = [Chunk]()
    var centerChunk: Chunk!
    
    var tileSize = CGSize(width: 64, height: 64)
    let chunkSize = CGSize(width: 16, height: 16)
    
    override init() {
        seed = arc4random() % UInt32(INT32_MAX)
        super.init()
        
        for x in -1...1 {
            for y in -1...1 {
                addChunk(chunkLocation: CGPoint(x: x, y: y))
            }
        }
        
        setCenterChunk(location: CGPoint(x: 0, y: 0))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addChunk(chunkLocation: CGPoint) {
        let chunk = Chunk(location: chunkLocation, tileSize: tileSize, chunkSize: chunkSize)
        chunk.generateChunk(seed: seed)
        addChild(chunk)
        chunks.append(chunk)
    }
    
    func removeChunks(){
        for i in 0..<chunks.count {
            if chunks[i].isShown == false && !chunks.isEmpty{
                chunks.remove(at: i)
            }
        }
    }
    
    func setCenterChunk(location: CGPoint) {
        for chunk in chunks {
            if chunk.chunkLocation == location {
                centerChunk = chunk
            }
        }
    }
    
    func showChunksAround(camera: SKCameraNode) {
        
        for chunk in chunks {
            chunk.removeFromParent()
        }
        chunks.removeAll()
        
        let point = camera.position
        
        let chunkPositionX = Int((point.x / chunkSize.width / tileSize.width * -1) / camera.xScale)
        let chunkPositionY = Int((point.y / chunkSize.height / tileSize.height * -1) / camera.yScale)
        
        for x in ( Int(chunkPositionX - 1) )...( Int(chunkPositionX + 1 )) {
            for y in ( Int(chunkPositionY - 1) )...( Int(chunkPositionY + 1) ) {
                var add = true
                for chunk in chunks {
                    if chunk.chunkLocation.x == CGFloat(x) && chunk.chunkLocation.y == CGFloat(y) {
                        add = false
                    }
                }
                
                if add {
                addChunk(chunkLocation: CGPoint(x: x, y: y))
                }
            }
        }
        
        setCenterChunk(location: CGPoint(x: chunkPositionX, y: chunkPositionY))
    }
    
}


