//
//  Trie.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 8/18/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation


public class TrieNode {
    
    public var key: String!
    public var children: Array<TrieNode>
    public var isFinal: Bool
    public var level: Int

    
    public init() {
        self.children = Array<TrieNode>()
        self.isFinal = false
        self.level = 0
    }

    
}


