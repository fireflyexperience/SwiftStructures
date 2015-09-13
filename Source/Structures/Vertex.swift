//
//  Vertex.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation


public class Vertex{
    
    public var key: String?
    public var neighbors: Array<Edge>
    public var visited: Bool = false

    public init() {
        self.neighbors = Array<Edge>()
    }
    
    
}
