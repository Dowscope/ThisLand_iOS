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
    
    var cameraScaleCurrent: CGFloat = 1
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        addChild(mainCamera)
        mainCamera.addChild(world)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.move(sender:)))
        self.view?.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        self.view?.addGestureRecognizer(tapGesture)
        
//        let scaleGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.scale(sender:)))
//        self.view?.addGestureRecognizer(scaleGesture)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    func addPoints(pointA: CGPoint, pointB: CGPoint) -> CGPoint {
        let x = pointA.x - pointB.x
        let y = pointA.y + pointB.y
        
        let intX = Int(x / world.chunkSize.width)
        let intY = Int(y / world.chunkSize.height)
        
        return CGPoint(x: intX, y: intY)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        print(mainCamera.position)
    }
    
    @objc func move(sender: UIPanGestureRecognizer){
        if sender.state == .began {
            var newPosition = mainCamera.position
            newPosition.y *= -1
            sender.setTranslation(newPosition, in: view)
        }
        if sender.state == .changed {
            var newPosition = sender.translation(in: view)
            newPosition.y *= -1
            mainCamera.position = newPosition
        }
        if sender.state == .ended {
            world.showChunksAround(camera: mainCamera)
            //print(mainCamera.position, mainCamera.xScale)
        }
    }
    //var newScale = CGFloat(0)
    
//    @objc func scale(sender: UIPinchGestureRecognizer){
//
//        if sender.state == .began {
//        }
//        if sender.state == .changed {
//            newScale += sender.velocity
//            print(newScale)
//            if newScale > 0.9 { newScale = 0.9 }
//            if newScale < 0.1 { newScale = 0.1 }
//            mainCamera.setScale(newScale)
//
//        }
//        if sender.state == .ended {
//        }
//    }
}
