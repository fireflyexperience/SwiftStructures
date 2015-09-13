//
//  File.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 8/4/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

//the path class maintains objects that comprise the "frontier"

public class Path {
    
    public var total: Int!
    public var destination: Vertex
    public var previous: Path!

    
    //object initialization
    public init(){
        destination = Vertex()
    }
    
}
