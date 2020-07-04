//
//  Graph.swift
//  WordSearch
//
//  Created by Christopher Devito on 7/2/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class LetterMap {
    var head: Node
    var tail: Node
    var length: Int
    var side: Int
    var values: [Character : [(Int, Int)]]
    var minX: Int
    var minY: Int
    var maxX: Int
    var maxY: Int

    init(node: Node, side: Int) {
        self.head = node
        self.tail = node
        self.length = 1
        self.side = side
        self.values = [node.value : [(1, 1)]]
        self.minX = 1
        self.minY = 1
        self.maxX = 1
        self.maxY = 1
    }

    func addToTail(value: Character) {
        let xNode = length % side == 0 ? 1 : tail.x + 1
        let yNode = length % side == 0 ? tail.y + 1 : tail.y
        let node = Node(value: value, x: <#T##Int#>, y: <#T##Int#>)
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

    func add(node: Node, before: Node) {

    }

    func add(node: Node, after: Node) {

    }

    func add(node: Node, above: Node) {

    }

    func add(node: Node, below: Node) {

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
    var value: Character
    var n: Node?
    var s: Node?
    var e: Node?
    var w: Node?
    let x: Int
    let y: Int

    init(value: Character = "0", x: Int, y: Int) {
        self.value = value
        self.x = x
        self.y = y
    }
}

extension LetterMap: Sequence, IteratorProtocol {
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
