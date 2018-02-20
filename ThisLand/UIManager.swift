//
//  UIManager.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-02-06.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import SpriteKit

enum ToolType {
    case WORKER
}

class UIManager: SKNode {
    
    let windowSize: CGRect
    
    let toggleBTN: SKShapeNode
    var toolBarIsActive = false
    var isToolSelected = false
    var toolSelected: ToolType = .WORKER
    
    var selectionInfo: SKShapeNode!
    var selectionBackGround: SKShapeNode!
    var selectionTitle: SKLabelNode!
    var selectionTileName: SKLabelNode!
    var selectionIsBuildable: SKLabelNode!
    var selectionIsHarvestable: SKLabelNode!
    
    var toolBarMenu: SKShapeNode!
    var tool_worker: SKShapeNode!
    var tool_worker_sprite: SKSpriteNode!
    
    var statusBar: SKShapeNode!
    var status_DayLbl: SKLabelNode!
    var status_MoneyLbl: SKLabelNode!
    
    init(rect: CGRect) {
        windowSize = rect
        
        toggleBTN = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 25, height: 25), cornerRadius: 10)
        toggleBTN.position = CGPoint(x: 10, y: 10)
        toggleBTN.fillColor = .red
        
        super.init()
        
        selectionInfo = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 150, height: 200))
        selectionInfo.lineWidth = 4
        selectionInfo.position = CGPoint(x: rect.width - 160, y: rect.height - 250)
        selectionInfo.alpha = 1
        
        selectionBackGround = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 150, height: 200))
        selectionBackGround.fillColor = .lightGray
        selectionBackGround.lineWidth = 0
        selectionBackGround.position = CGPoint.zero
        
        selectionTitle = SKLabelNode(text: "Tile Selected")
        selectionTitle.horizontalAlignmentMode = .center
        selectionTitle.fontSize = 20
        selectionTitle.fontName = "Georgia Bold"
        selectionTitle.fontColor = .white
        selectionTitle.position = CGPoint(x: 75, y: 170)
        
        selectionTileName = SKLabelNode(text: "Tile: ")
        selectionTileName.horizontalAlignmentMode = .left
        selectionTileName.fontSize = 16
        selectionTileName.fontName = "Georgia Bold"
        selectionTileName.fontColor = .white
        selectionTileName.position = CGPoint(x: 5, y: 140)
        selectionTileName.alpha = 1
        
        selectionIsBuildable = SKLabelNode(text: "Building Allowed")
        selectionIsBuildable.horizontalAlignmentMode = .left
        selectionIsBuildable.fontSize = 12
        selectionIsBuildable.fontName = "Georgia Bold"
        selectionIsBuildable.fontColor = SKColor.green
        selectionIsBuildable.position = CGPoint(x: 5, y: 120)
        selectionIsBuildable.alpha = 1
        
        selectionIsHarvestable = SKLabelNode(text: "Not Harvestable")
        selectionIsHarvestable.horizontalAlignmentMode = .left
        selectionIsHarvestable.fontSize = 12
        selectionIsHarvestable.fontName = "Georgia Bold"
        selectionIsHarvestable.fontColor = SKColor.red
        selectionIsHarvestable.position = CGPoint(x: 5, y: 108)
        selectionIsHarvestable.alpha = 1
        
        
        toolBarMenu = SKShapeNode(rect: CGRect(x: 0, y: 0, width: rect.width - 75, height: 50), cornerRadius: 10)
        toolBarMenu.fillColor = .gray
        toolBarMenu.lineWidth = 0
        toolBarMenu.position = CGPoint(x: 50, y: 10)
        toolBarMenu.isHidden = true
        
        tool_worker = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 40, height: 40), cornerRadius: 10)
        tool_worker.fillColor = .white
        tool_worker.lineWidth = 4
        tool_worker.strokeColor = .black
        tool_worker.position = CGPoint(x: 5, y: 5)
        tool_worker.name = "Tool_Worker"
        
        tool_worker_sprite = SKSpriteNode(imageNamed: "Worker_Down_Stand")
        tool_worker_sprite.position = CGPoint(x: 4, y: 4)
        tool_worker_sprite.anchorPoint = CGPoint.zero
        
        statusBar = SKShapeNode(rect: CGRect(x: 0, y: 0, width: rect.width, height: 20))
        statusBar.fillColor = .blue
        statusBar.lineWidth = 0
        statusBar.position = CGPoint(x: 0, y: rect.maxY - 20)
        
        status_DayLbl = SKLabelNode(text: "Day 0")
        status_DayLbl.horizontalAlignmentMode = .left
        status_DayLbl.fontSize = 16
        status_DayLbl.fontName = "Georgia Bold"
        status_DayLbl.fontColor = SKColor.yellow
        status_DayLbl.position = CGPoint(x: 5, y: 3)
        status_DayLbl.zPosition = 2
        
        status_MoneyLbl = SKLabelNode(text: "$10000.00")
        status_MoneyLbl.horizontalAlignmentMode = .right
        status_MoneyLbl.fontSize = 16
        status_MoneyLbl.fontName = "Georgia Bold"
        status_MoneyLbl.fontColor = SKColor.green
        status_MoneyLbl.position = CGPoint(x: rect.width - 5, y: 3)
        status_MoneyLbl.zPosition = 2
        
        addChild(toggleBTN)
        
        addChild(selectionInfo)
        selectionInfo.addChild(selectionBackGround)
        selectionInfo.addChild(selectionTitle)
        selectionInfo.addChild(selectionTileName)
        selectionInfo.addChild(selectionIsBuildable)
        selectionInfo.addChild(selectionIsHarvestable)
        
        addChild(toolBarMenu)
        toolBarMenu.addChild(tool_worker)
        tool_worker.addChild(tool_worker_sprite)
        
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
            isToolSelected = false
            tool_worker.strokeColor = .black
        }else {
            toolBarIsActive = true
            toggleBTN.fillColor = .green
            toolBarMenu.isHidden = false
        }
    }
    
    func tileSelection(of tile: Tile) {
        let name = tile.getTypeString()
        let preName = "Type: "
        selectionTileName.text = preName + name
        selectionInfo.isHidden = false
        
        if tile.isBuildable {
            selectionIsBuildable.text = "Building Allowed"
            selectionIsBuildable.fontColor = .green
        } else {
            selectionIsBuildable.text = "Building Not Allowed"
            selectionIsBuildable.fontColor = .red
        }
        
        if tile.isHarvestable {
            selectionIsHarvestable.text = "Harvestable"
            selectionIsHarvestable.fontColor = .green
        } else {
            selectionIsHarvestable.text = "Not Harvestable"
            selectionIsHarvestable.fontColor = .red
        }
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
    
    func toolSelect(type: ToolType) {
        switch type {
        case .WORKER:
            tool_worker.strokeColor = .green
            isToolSelected = true
            toolSelected = .WORKER
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
