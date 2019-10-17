//
//  GameScene.swift
//  BabaIsYou-F19
//
//  Created by Parrot on 2019-10-17.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var baba : SKSpriteNode!
    let PLAYER_SPEED:CGFloat = 50
    var flag:SKSpriteNode!
    var wallBlock : SKSpriteNode!
    var babaXPosition : CGFloat!
    var babaYPosition : CGFloat!
    var flagBlock : SKSpriteNode!
    var isBlock : SKSpriteNode!
    var winBlock : SKSpriteNode!
    var stopBlock : SKSpriteNode!
    
    
    var activeStatus=false
    var wall:SKSpriteNode!
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        self.baba = self.childNode(withName: "baba") as? SKSpriteNode
        self.baba.physicsBody?.categoryBitMask = 4
        
        self.wall = self.childNode(withName: "wall") as? SKSpriteNode
        self.wall.physicsBody?.categoryBitMask = 2
        
        self.flag = self.childNode(withName: "flag") as? SKSpriteNode
        self.flag.physicsBody?.categoryBitMask = 8
        
        self.wallBlock = self.childNode(withName: "wallBlock") as? SKSpriteNode
        self.wallBlock.physicsBody?.categoryBitMask = 64
        
        self.flagBlock = self.childNode(withName: "flagBlock") as? SKSpriteNode
        self.flagBlock.physicsBody?.categoryBitMask = 32
        
        self.stopBlock = self.childNode(withName: "stopBlock") as? SKSpriteNode
        self.stopBlock.physicsBody?.categoryBitMask = 128
        
        self.winBlock = self.childNode(withName: "winBlock") as? SKSpriteNode
        self.winBlock.physicsBody?.categoryBitMask = 256
        
        self.isBlock = self.childNode(withName: "isBlock") as? SKSpriteNode
        self.isBlock.physicsBody?.categoryBitMask = 512
    }
   
    func didBegin(_ contact: SKPhysicsContact) {
        print("Something collided!")
        let node1 = contact.bodyA.node
        let node2 = contact.bodyB.node
        
        if node1 == nil || node2 == nil{
            return
        }
        
      blockDetection()
        if(activeStatus == false)
        {
            if node1!.name == "baba" && node2!.name == "wall"
            {
                self.baba.physicsBody?.collisionBitMask = 4
                self.wall.physicsBody?.affectedByGravity = false
                self.wall.physicsBody!.isDynamic = false
            }
                
            else if(node1!.name == "wall" && node2!.name == "baba"){
                self.baba.physicsBody?.collisionBitMask = 4
                self.wall.physicsBody?.affectedByGravity = false
                self.wall.physicsBody!.isDynamic = false
            }
        }
        
        
        if node1!.name == "baba" && node2!.name == "flag"
        {
            print("you Won game")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let mouseTouch=touches.first
        if(mouseTouch==nil)
        {
            return
        }
        
        //figure wt node did when touches the player
        let location=mouseTouch!.location(in: self)
        let nodeTouched = atPoint(location).name
        print("player touched\(nodeTouched)")
        //game logic
        if(nodeTouched=="upbutton")
        {
            self.baba.position.y=self.baba.position.y+PLAYER_SPEED
        }
        else if(nodeTouched=="downbutton")
        {
            self.baba.position.y=self.baba.position.y-PLAYER_SPEED
        }
        else if(nodeTouched=="leftbutton")
        {
            self.baba.position.x=self.baba.position.x-PLAYER_SPEED
        }
        else if(nodeTouched=="rightbutton")
        {
            self.baba.position.x=self.baba.position.x+PLAYER_SPEED
        }
        
    
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
    func blockDetection(){
        if(self.wallBlock.position.y == self.isBlock.position.y){
            if(self.wallBlock.position.y == self.stopBlock.position.y){
                activeStatus = false
            }
        }
        else
            if((self.flag.position.y == self.isBlock.position.y)){
                if(self.flag.position.y == self.stopBlock.position.y){
                    activeStatus = false
                }
                
            }
            else if(self.flagBlock.position.y == self.isBlock.position.y){
                if(self.flagBlock.position.y == self.winBlock.position.y){
                    activeStatus = true
                }
                else
                    if(self.wallBlock.position.y == self.isBlock.position.y){
                        if(self.wallBlock.position.y == self.winBlock.position.y){
                            activeStatus = true
                        }
                        
                }
}
}

}
