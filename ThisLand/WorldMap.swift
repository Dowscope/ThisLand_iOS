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
        //addChunk(chunkLocation: CGPoint(x: 0, y: 0))
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
    
    func getTile(at point: CGPoint) -> Tile? {
        
        var chunkPosX = Int((point.x / tileSize.width) / chunkSize.width)
        if point.x < 0 { chunkPosX -= 1 }
        var chunkPosY = Int((point.y / tileSize.height) / chunkSize.height)
        if point.y < 0 { chunkPosY -= 1 }
        
        for chunk in chunks {
            if chunk.chunkLocation == CGPoint(x: chunkPosX, y: chunkPosY) {
                let col = CGFloat(Int((point.x - chunk.position.x) / tileSize.width))
                let row = CGFloat(Int((point.y - chunk.position.y) / tileSize.height))
                
                return chunk.getTile(at: CGPoint(x: col, y: row))
                //return chunk.tileMap.tileDefinition(atColumn: Int(col), row: Int(row))
                
            }
        }
        return nil
    }
    
    var selectionMade = false
    var selection: SKShapeNode!
    
    func drawSelectionBox(at point: CGPoint) -> Tile? {
        
        if selectionMade {
            selection.removeFromParent()
            selection = nil
            selectionMade = false
        }
        if let tile = getTile(at: point) {
            var newP = point
            
            if newP.x < 0 { newP.x -= tileSize.width }
            if newP.y < 0 { newP.y -= tileSize.height }
            
            let x = CGFloat(Int(newP.x / tileSize.width)) * tileSize.width
            let y = CGFloat(Int(newP.y / tileSize.height)) * tileSize.height
            let rect = CGRect(x: x, y: y, width: tileSize.width, height: tileSize.height)
            
            selection = SKShapeNode(rect: rect, cornerRadius: 10)
            selection.strokeColor = .red
            selection.lineWidth = 5
            selectionMade = true
            addChild(selection)
            if tile.getTypeString() == "Grass" {
                selection.strokeColor = .green
            }
            
            return tile
        }else {
            print("Tile not found")
        }
        return nil
    }
}


