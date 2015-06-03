//
//  Stack.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 8/1/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation


public class SwiftStack<T> {
    
    private var top: LLNode<T>! = LLNode<T>()

    
    //TODO: Add count computed property
    
    
    //push an item onto the stack
    public func push(var key: T) {
        
        
        //check for the instance
        if (top == nil) {
            top = LLNode<T>()
        }
        
        
        //determine if the head node is populated
        if (top.key == nil){
            top.key = key;
            return
        }
        else {
            
            //establish the new item instance
            var childToUse: LLNode<T> = LLNode<T>()
            childToUse.key = key
            
            
            //set newly created item at the top
            childToUse.next = top;
            top = childToUse;
            
         
        }

    }
    
    
    
    //remove an item from the stack
    public func pop() -> T? {
     
        //determine if the key or instance exist
        let topitem: T? = self.top?.key
        
        if (topitem == nil){
            return nil
        }
        
        //retrieve and queue the next item
        var queueitem: T? = top.key!
        
        
        //reset the top value
        if let nextitem = top.next {
            top = nextitem
        }
        else {
            top = nil
        }
        
        
        return queueitem

    }
    
    
    
    //retrieve the top most item
    public func peek() -> T? {

        
        //determine if the key or instance exist
        if let topitem: T = self.top?.key {
            return topitem
        }
            
        else {
            return nil
        }
        
        
    }
    
    
    
    //check for the presence of a value
    public func isEmpty() -> Bool {
        
        //determine if the key or instance exist
        if let topitem: T = self.top?.key {
            return false
        }
            
        else {
            return true
        }
        
    }
    
    
    
    //determine the count of the queue
    public func count() -> Int {
        
        var x: Int = 0
        
        
        //determine if the key or instance exist
        let topitem: T? = self.top?.key
        
        if (topitem == nil) {
             return 0
        }
        
        
        var current: LLNode = top
        
        x++
        
        //cycle through the list of items to get to the end.
        while ((current.next) != nil) {
            current = current.next!;
            x++
        }
        
        return x
        
    }
    

}