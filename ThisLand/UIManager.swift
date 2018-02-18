//
//  UIManager.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-02-06.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import SpriteKit

class UIManager: SKNode {
    
    let windowSize: CGRect
    
    let toggleBTN: SKShapeNode
    var toolBarIsActive = false
    
    let selectionInfo: SKShapeNode
    let selectionTitle: SKLabelNode
    let selectionTileName: SKLabelNode
    
    let toolBarMenu: SKShapeNode
    
    var statusBar: SKShapeNode!
    var status_DayLbl: SKLabelNode!
    var status_MoneyLbl: SKLabelNode!
    
    init(rect: CGRect) {
        windowSize = rect
        
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
        
        toolBarMenu = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 600, height: 50), cornerRadius: 10)
        toolBarMenu.fillColor = .gray
        toolBarMenu.lineWidth = 0
        
        super.init()
        
        selectionInfo.position = CGPoint(x: 500, y: 150)
        selectionInfo.alpha = 0.5
        
        toolBarMenu.position = CGPoint(x: 50, y: 10)
        toolBarMenu.isHidden = true
        
        statusBar = SKShapeNode(rect: CGRect(x: 0, y: 0, width: rect.width, height: 20))
        statusBar.fillColor = .blue
        statusBar.lineWidth = 0
        statusBar.position = CGPoint(x: 0, y: rect.maxY - 20)
        
        status_DayLbl = SKLabelNode(text: "Day 0")
        status_DayLbl.horizontalAlignmentMode = .left
        status_DayLbl.fontSize = 16
        status_DayLbl.fontName = "Georgia Bold"
        status_DayLbl.color = SKColor.yellow
        status_DayLbl.position = CGPoint(x: 5, y: 3)
        
        status_MoneyLbl = SKLabelNode(text: "$10000.00")
        status_MoneyLbl.horizontalAlignmentMode = .right
        status_MoneyLbl.fontSize = 16
        status_MoneyLbl.fontName = "Georgia Bold"
        status_MoneyLbl.color = SKColor.green
        status_MoneyLbl.position = CGPoint(x: rect.width - 5, y: 3)
        
        addChild(toggleBTN)
        addChild(selectionInfo)
        selectionInfo.addChild(selectionTitle)
        selectionInfo.addChild(selectionTileName)
        
        addChild(toolBarMenu)
        
        addChild(statusBar)
        statusBar.addChild(status_DayLbl)
        statusBar.addChild(status_MoneyLbl)
        
        selectionInfo.isHidden = true
    }
    
    func toggle() {
        if toolBarIsActive {
            toolBarIsActive = false
            toggleBTN.fillColor = .red
            toolBarMenu.isHidden = true
        }else {
            toolBarIsActive = true
            toggleBTN.fillColor = .green
            toolBarMenu.isHidden = false
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
    
    func updateMoneyLabel(amount: CGFloat){
        status_MoneyLbl.text = "$\(amount)"
    }
    
    func updateDayLabel(amount: Int){
        status_DayLbl.text = "Day \(amount)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
