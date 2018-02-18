//
//  UIManager.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-02-06.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import SpriteKit

class UIManager: SKNode {
    
    let toggleBTN: SKShapeNode
    var isActive = false
    
    let selectionInfo: SKShapeNode
    let selectionTitle: SKLabelNode
    let selectionTileName: SKLabelNode
    
    override init() {
        toggleBTN = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 25, height: 25), cornerRadius: 10)
        toggleBTN.position = CGPoint(x: 10, y: 10)
        toggleBTN.fillColor = .red
        
        selectionInfo = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 150, height: 200))
        selectionInfo.fillColor = .gray
        selectionInfo.lineWidth = 0
        
        selectionTitle = SKLabelNode(text: "Tile Selected")
        selectionTitle.horizontalAlignmentMode = .center
        selectionTitle.fontSize = 20
        selectionTitle.fontName = "Georgia Bold"
        selectionTitle.color = .white
        selectionTitle.position = CGPoint(x: 75, y: 170)
        
        selectionTileName = SKLabelNode(text: "Tile: ")
        selectionTileName.horizontalAlignmentMode = .left
        selectionTileName.fontSize = 16
        selectionTileName.fontName = "Georgia Bold"
        selectionTileName.color = .white
        selectionTileName.position = CGPoint(x: 5, y: 140)
        selectionTileName.alpha = 1
        super.init()
        
        
        selectionInfo.position = CGPoint(x: 500, y: 150)
        selectionInfo.alpha = 0.5
        
        addChild(toggleBTN)
        addChild(selectionInfo)
        selectionInfo.addChild(selectionTitle)
        selectionInfo.addChild(selectionTileName)
        
        selectionInfo.isHidden = true
    }
    
    func toggle() {
        if isActive {
            isActive = false
            toggleBTN.fillColor = .red
        }else {
            isActive = true
            toggleBTN.fillColor = .green
        }
    }
    
    func tileSelection(of tile: SKTileDefinition) {
        let name = tile.name
        let preName = "Tile: "
        selectionTileName.text = preName + name!
        selectionInfo.isHidden = false
    }
    
    func closeSelectionInfo() {
        selectionInfo.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
