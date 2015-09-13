//
//  QNode.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/12/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation


//generic queue node

public class QNode<T> {
    
    public var key: T? = nil
    public var next: QNode? = nil

}

