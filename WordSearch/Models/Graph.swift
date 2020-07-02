//
//  Graph.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/2/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class Graph {
    var head: Node
    var tail: Node
    var length: Int
    var side: Int

    init(node: Node, side: Int) {
        self.head = node
        self.tail = node
        self.length = 1
        self.side = side
    }

    func addToTail(value: Character) {
        let node = Node()
        node.value = value

        if length % side != 0 {
            node.w = tail
            node.n = tail.n?.e
            tail.e = node
        } else {
            node.w = nil
            var rowHead = head
            while true {
                if rowHead.s != nil {
                    rowHead = rowHead.s!
                    continue
                } else {
                    break
                }
            }
            node.n = rowHead
            rowHead.s = node
        }
        node.s = nil
        node.e = nil
        tail = node
        length += 1
    }

    func getVelue(x: Int, y: Int) {
        if x > side || y > side { fatalError("No node at that position") }
        var searchNode: Node = head
        for _ in 0...x {
            searchNode = searchNode.e!
        }
        for _ in 0...y {
            searchNode = searchNode.s!
        }
    }
}

class Node {
    var value: Character = "0"
    var n: Node?
    var s: Node?
    var e: Node?
    var w: Node?
}

extension Graph: Sequence, IteratorProtocol {
    var count: Int {
        length
    }

    public func next() -> Node? {
        if count > self.count {
            return nil
        } else {
            defer {
                //something
            }
            return nil // should be something else
        }
    }
}
