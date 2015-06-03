//
//  GraphFactory.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation


public class SwiftGraph {
   
    
    //declare a default directed graph canvas
    private var canvas: Array<Vertex>
    public var isDirected: Bool
    
    
    public init() {
        canvas = Array<Vertex>()
        isDirected = true
    }
    
    
    //create a new vertex
    public func addVertex(#key: String) -> Vertex {
        
        
        //set the key
        var childVertex: Vertex = Vertex()
        childVertex.key = key
        
        
        //add the vertex to the graph canvas
        canvas.append(childVertex)
        
        
        return childVertex
    }
    
    
    
    //add edge to source vertex
    public func addEdge(#source: Vertex, neighbor: Vertex, weight: Int) {
        
        
        //create a new edge
        var newEdge = Edge()
        
        
        //establish the default properties
        newEdge.neighbor = neighbor
        newEdge.weight = weight
        source.neighbors.append(newEdge)
        
        
        println("The neighbor of vertex: \(source.key as String!) is \(neighbor.key as String!)..")
        
        
        //check condition for an undirected graph
        if (isDirected == false) {
            
            
            //create a new reversed edge
            var reverseEdge = Edge()
            
            
            //estabish the reversed properties
            reverseEdge.neighbor = source
            reverseEdge.weight = weight
            neighbor.neighbors.append(reverseEdge)
            
            println("The neighbor of vertex: \(neighbor.key as String!) is \(source.key as String!)..")
            
        }
        
        
    }

    
    
   //breadth first search
   public func traverseGraphBFS(startingv: Vertex) {

    
        //establish a new queue
        var graphQueue: Queue<Vertex> = Queue<Vertex>()
    
    
        //queue a starting vertex
        graphQueue.enQueue(startingv)
    
        while(!graphQueue.isEmpty()) {
            
            //traverse the next queued vertex
            var vitem = graphQueue.deQueue() as Vertex!
            
            
            //add unvisited vertices to the queue
            for e in vitem.neighbors {
                if e.neighbor.visited == false {
                    println("adding vertex: \(e.neighbor.key!) to queue..")
                    graphQueue.enQueue(e.neighbor)
                }
            }
            
            
            vitem.visited = true
            println("traversed vertex: \(vitem.key!)..")
            
            
        } //end while
    
    
        println("graph traversal complete..")
    
    
    } //end function
    
    
    
    
    
    /* reverse the sequence of paths given the shortest path.
       process analagous to reversing a linked list. */

    public func reversePath(var head: Path!, source: Vertex) -> Path! {
        
        if (head == nil) {
            return nil;
        }
        
        
        var current: Path! = head
        var prev: Path!
        var next: Path!
        
        
        while(current != nil) {
            next = current.previous
            current.previous = prev
            prev = current
            current = next
        }
        
        
        //append the source path to the sequence
        var sourcePath: Path = Path()
        
        sourcePath.destination = source
        sourcePath.previous = prev
        sourcePath.total = nil
        
        head = sourcePath
        
        
        return head
        
    }

    
    
    
    //process Dijkstra's shortest path algorthim
    public func processDijkstra(source: Vertex, destination: Vertex) -> Path? {
        
        
        var frontier: Array<Path> = Array<Path>()
        var finalPaths: Array<Path> = Array<Path>()
        
        
        //use source edges to create the frontier
        for e in source.neighbors {
            
            var newPath: Path = Path()
            
            
            newPath.destination = e.neighbor
            newPath.previous = nil
            newPath.total = e.weight
            
            
            //add the new path to the frontier
            frontier.append(newPath)
            
        }
        

        //construct the best path
        var bestPath: Path = Path()
        
        
        while(frontier.count != 0) {

            
            //support path changes using the greedy approach
            bestPath = Path()
            
            
            var x: Int = 0
            var pathIndex: Int = 0
            
            
            for (x = 0; x < frontier.count; x++) {

                var itemPath: Path = frontier[x]
                
                if  (bestPath.total == nil) || (itemPath.total < bestPath.total) {
                    bestPath = itemPath
                    pathIndex = x
                }
                
            }

            
            //enumerate the bestPath edges
            for e in bestPath.destination.neighbors {
                
                var newPath: Path = Path()
                
                newPath.destination = e.neighbor
                newPath.previous = bestPath
                newPath.total = bestPath.total + e.weight
                
                
                //add the new path to the frontier
                frontier.append(newPath)
                
            }
            
            
            //preserve the bestPath
            finalPaths.append(bestPath)
            
            
            //remove the bestPath from the frontier
            frontier.removeAtIndex(pathIndex)
            
            
        } //end while
        
        
    
        //establish the shortest path as an optional
        var shortestPath: Path! = Path()
        
        
        for itemPath in finalPaths {
            
            if (itemPath.destination.key == destination.key) {
                
                if  (shortestPath.total == nil) || (itemPath.total < shortestPath.total) {
                    shortestPath = itemPath
                }
                
            }
            
        }
        
        
        return shortestPath
        
    }
    
    
    
    ///an optimized version of Dijkstra's shortest path algorthim
    public func processDijkstraWithHeap(source: Vertex, destination: Vertex) -> Path! {
        
        
        var frontier: PathHeap = PathHeap()
        var finalPaths: PathHeap = PathHeap()
        
        
        //use source edges to create the frontier
        for e in source.neighbors {
            
            var newPath: Path = Path()
            
            
            newPath.destination = e.neighbor
            newPath.previous = nil
            newPath.total = e.weight
            
            
            //add the new path to the frontier
            frontier.enQueue(newPath)
            
        }
        
        
        //construct the best path
        var bestPath: Path = Path()
        
        
        while(frontier.count != 0) {
            
            
            //use the greedy approach to obtain the best path
            bestPath = Path()
            bestPath = frontier.peek()
            
            
            //enumerate the bestPath edges
            for e in bestPath.destination.neighbors {
                
                var newPath: Path = Path()
                
                newPath.destination = e.neighbor
                newPath.previous = bestPath
                newPath.total = bestPath.total + e.weight
                
                
                //add the new path to the frontier
                frontier.enQueue(newPath)
                
            }
            
            
            //preserve the bestPaths that match destination
            if (bestPath.destination.key == destination.key) {
                finalPaths.enQueue(bestPath)
            }
            
            
            //remove the bestPath from the frontier
            frontier.deQueue()
            
            
        } //end while
        
        
        
        //obtain the shortest path from the heap
        var shortestPath: Path! = Path()
        shortestPath = finalPaths.peek()
        
        
        return shortestPath
        
    }
    


    
    
}