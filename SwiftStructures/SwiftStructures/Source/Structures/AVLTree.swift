//
//  AVLNode.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/26/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation


/* An AVL Tree is another name for a balanced binary search tree*/

public class AVLTree<T: Comparable> {
    
    public var key: T?
    public var left: AVLTree?
    public var right: AVLTree?
    public var height: Int
   
    public init() {
        //set math purposes
        self.height = -1
    }
    
    
    //function to add item based on its value
    public func addNode(key: T) {
        
        //check for the root node
        if (self.key == nil) {
            self.key = key
            self.height = 0
            return
        }
        
        
        //check the left side of the tree
        if (key < self.key) {
            
            
            if (self.left != nil) {
                left?.addNode(key)
            }
                
            else {
                //create a new left node
                var leftChild : AVLTree = AVLTree()
                leftChild.key = key
                leftChild.height = 0
                self.left = leftChild
            }
            
            //recalculate node height for hierarchy
            self.setNodeHeight()
            println("traversing left side. node \(self.key!) with height: \(self.height)...")


            //check AVL property
            self.isValidAVLTree()

            
            
        } //end if
       
        
        
        //check the left side of the tree
        if (key > self.key) {            
            
            if (self.right != nil) {
                right?.addNode(key)
            }
                
            else {
                //create a new right node
                var rightChild : AVLTree = AVLTree()
                rightChild.key = key
                rightChild.height = 0
                self.right = rightChild
                         
            }
            
            //recalculate node height for hierarchy
            self.setNodeHeight()
            println("traversing right side. node \(self.key!) with height: \(self.height)...")
            
            
            //check AVL property
            self.isValidAVLTree()
            
            
            
        } //end if

        
    } //end function


    
    
    // MARK: - tree balancing algorithms

    
    
    //retrieve the height of a node
    public func getNodeHeight(aNode: AVLTree!) -> Int {
        
        if (aNode == nil) {
            return -1
        }
        else {
           return aNode.height
        }
        
    }
    
    
    
    //calculate the height of a node
    public func setNodeHeight() -> Bool {
        
        
        //check for a nil condition
        if (self.key == nil) {
            println("no key provided..")
            return false
        }
        
        //println("key: \(self.key!)")
        

        //initialize leaf variables
        var nodeHeight: Int = 0
        
        
        //do comparision and calculate node height
        nodeHeight = max(getNodeHeight(self.left), getNodeHeight(self.right)) + 1
        
        self.height = nodeHeight
        
        return true
        
    }
    

    
    //determine if the tree is "balanced" - operations on a balanced tree is O(log n)
    public func isTreeBalanced() -> Bool {

        
        //check for a nil condition
        if (self.key == nil) {
            println("no key provided..")
            return false
        }
        
        
        //use absolute value to manage right and left imbalances
        if (abs(getNodeHeight(self.left) - getNodeHeight(self.right)) <= 1) {
            return true
        }
        else {
            return false
        }
        
        
    } //end function

    

    
    //check to ensure node meets avl property
    public func isValidAVLTree() -> Bool! {
        
        
        //check for valid scenario
        if (self.key == nil) {
            println("no key provided..")
            return false
        }
        
        
        if (self.isTreeBalanced() == true) {
            println("node \(self.key!) already balanced..")
            return true
        }
        
        //determine rotation type
        else {
            
            
            //create a new leaf node
            var childToUse : AVLTree = AVLTree()
            childToUse.height = 0
            childToUse.key = self.key
            
            
            if (getNodeHeight(self.left) - getNodeHeight(self.right) > 1) {
                
                println("\n starting right rotation on \(self.key!)..")
                
                
                //reset the root node
                self.key = self.left?.key
                self.height = getNodeHeight(self.left)

                
                //assign the new right node
                self.right = childToUse
                

                //adjust the left node
                self.left = self.left?.left
                self.left?.height = 0
                
                println("root is: \(self.key!) | left is : \(self.left!.key!) | right is : \(self.right!.key!)..")
                
                return true
                
            }

            
            if (getNodeHeight(self.right) - getNodeHeight(self.left) > 1) {
                
                println("\n starting left rotation on \(self.key!)..")
                
                //reset the root node
                self.key = self.right?.key
                self.height = getNodeHeight(self.right)
                
                
                //assign the new left node
                self.left = childToUse
                
                
                //adjust the right node
                self.right = self.right?.right
                self.right?.height = 0
                
                println("root is: \(self.key!) | left is : \(self.left!.key!) | right is : \(self.right!.key!)..")
                
                return true
                
            }
            
            
            return nil


            
        } //end if
        

        
    } //end function

    
    
    // MARK: traversal algorithm
    
    
    //depth first search in-order traversal
    public func processAVLDepthTraversal() {
        
        
        //check for a nil condition
        if (self.key == nil) {
            println("no key provided..")
            return
        }
        
        
        //process the left side
        if (self.left != nil) {
            left?.processAVLDepthTraversal()
        }
        
        println("..the traversed value is: \(self.key!). height: \(self.height)..")
        
        //process the right side
        if (self.right != nil) {
            right?.processAVLDepthTraversal()
        }
        
        
    } //end function


    

} //end class