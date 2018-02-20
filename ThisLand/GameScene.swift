//
//  GameScene.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-01-28.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let world = WorldMap()
    let mainCamera = SKCameraNode()
    var uiManager: UIManager!
    
    var player = Player()
    
    var cameraScaleCurrent: CGFloat = 1
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        anchorPoint = CGPoint.zero
        
        uiManager = UIManager(rect: view.bounds)
        uiManager.zPosition = 10
        addChild(uiManager)
        
        addChild(mainCamera)
        mainCamera.addChild(world)
        mainCamera.addChild(player)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.move(sender:)))
        self.view?.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        self.view?.addGestureRecognizer(tapGesture)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    func addPoints(pointA: CGPoint, pointB: CGPoint) -> CGPoint {
        let x = (-1 * pointA.x) + pointB.x
        let y = (-1 * pointA.y) + pointB.y
        
        return CGPoint(x: x, y: y)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        var location = sender.location(in: view)
        let uiLoc = view?.convert(location, to: scene!)
        let touchedNode = self.nodes(at: uiLoc!)
        
        if uiManager.toolBarIsActive {
            for node in touchedNode {
                if let name = node.name {
                    if name == "Tool_Worker" {
                        uiManager.toolSelect(type: .WORKER)
                        return
                    }
                }
            }
            
            if uiManager.isToolSelected {
                if uiManager.toolSelected == .WORKER {
                    let toolLoc = (view?.convert(location, from: scene!))!
                    //player.addWorker(at: location)
                }
            }
        }
        
        if uiManager.toggleBTN.contains(uiLoc!) {
            uiManager.toggle()
            
        } else {
            location = (view?.convert(location, from: scene!))!
            let tile = world.drawSelectionBox(at: addPoints(pointA: mainCamera.position, pointB: location))
            uiManager.tileSelection(of: tile!)
        }
        
        
    }
    
    @objc func move(sender: UIPanGestureRecognizer){
        if sender.state == .began {
            var newPosition = mainCamera.position
            newPosition.y *= -1
            sender.setTranslation(newPosition, in: view)
            uiManager.closeSelectionInfo()
        }
        if sender.state == .changed {
            var newPosition = sender.translation(in: view)
            newPosition.y *= -1
            mainCamera.position = newPosition
        }
        if sender.state == .ended {
            world.showChunksAround(camera: mainCamera)
        }
    }
}
