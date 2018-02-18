//
//  Chunk.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-01-30.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import SpriteKit
import GameplayKit

class Chunk: SKNode {
    
    var seed: UInt32 = 0
    var chunkLocation: CGPoint
    
    var noiseMap: GKNoiseMap!
    
    var greenDef: SKTileDefinition!
    var blueDef: SKTileDefinition!
    var brownDef: SKTileDefinition!
    var greenGrp: SKTileGroup!
    var blueGrp: SKTileGroup!
    var brownGrp: SKTileGroup!
    var tileMap: SKTileMapNode!
    
    var chunkSize: CGSize!
    var tileSize: CGSize!
    var isShown: Bool
    
    var tiles = [Tile]()

    init(location: CGPoint, tileSize: CGSize, chunkSize: CGSize){
        self.tileSize = tileSize
        self.chunkSize = chunkSize
        self.chunkLocation = location
        self.isShown = true
        super.init()
        
        position.x = location.x * (chunkSize.width * tileSize.width)
        position.y = location.y * (chunkSize.height * tileSize.height)
        
        let greenTexture = SKTexture(imageNamed: "Grass")
        greenDef = SKTileDefinition(texture: greenTexture, size: tileSize)
        greenDef.name = "Grass"
        greenGrp = SKTileGroup(tileDefinition: greenDef)
        
        let blueTexture = SKTexture(imageNamed: "Water")
        blueDef = SKTileDefinition(texture: blueTexture, size: tileSize)
        blueDef.name = "Water"
        blueGrp = SKTileGroup(tileDefinition: blueDef)
        
        let brownTexture = SKTexture(imageNamed: "TreeTile")
        brownDef = SKTileDefinition(texture: brownTexture, size: tileSize)
        brownDef.name = "Trees"
        brownGrp = SKTileGroup(tileDefinition: brownDef)
        
        
        let tileSet = SKTileSet(tileGroups: [greenGrp, blueGrp, brownGrp])
        tileMap = SKTileMapNode(tileSet: tileSet,
                                columns: Int(chunkSize.width),
                                rows: Int(chunkSize.height),
                                tileSize: tileSize)
        tileMap.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(tileMap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateChunk(seed: UInt32){
        let perlinNoiseSource = GKPerlinNoiseSource(frequency: Double(chunkSize.width / 4),
                                                    octaveCount: 3,    // 3
                                                    persistence: 3,   // 1.75
                                                    lacunarity: 0.25,    // 5
                                                    seed: Int32(seed))
        
        let noise = GKNoise(perlinNoiseSource)
        let newPosition = vector_double3(Double(Float(chunkLocation.x * tileSize.width)), Double(Float(chunkLocation.y * tileSize.height)), Double(Float(0)))
        noise.move(by: newPosition)
        noiseMap = GKNoiseMap(noise,
                              size: [Double(chunkSize.width),
                                     Double(chunkSize.height)],
                              origin: [Double(chunkLocation.x),
                                       Double(chunkLocation.y)],
                              sampleCount: [Int32(tileSize.width),
                                            Int32(tileSize.height)],
                              seamless: true)
        
        for x in 0...Int(chunkSize.width) {
            for y in 0..<Int(chunkSize.height){
                let point: int2 = [Int32(x),
                                   Int32(y)]
                
                let noiseValue = Float(noiseMap.value(at: point))
                //print(noiseValue)
                
                if noiseValue < -0.7 {
                    tileMap.setTileGroup(blueGrp, andTileDefinition: blueDef, forColumn: x, row: y)
                    tiles.append(Tile(type: TileType.WATER, location: CGPoint(x: x, y: y)))
                }
                else if noiseValue > 0.8 {
                    tileMap.setTileGroup(brownGrp, andTileDefinition: brownDef, forColumn: x, row: y)
                    tiles.append(Tile(type: TileType.TREES, location: CGPoint(x: x, y: y)))
                }
                else {
                    tileMap.setTileGroup(greenGrp, andTileDefinition: greenDef, forColumn: x, row: y)
                    tiles.append(Tile(type: TileType.GRASS, location: CGPoint(x: x, y: y)))
                }
            }
        }
    }
    
    func getTile(at point: CGPoint) -> Tile {
        let index = Int(point.x + point.y * chunkSize.width)
        print(point, tiles[index].getTypeString() )
        return tiles[index]
    }
}
