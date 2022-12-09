//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    
    var trees = [[Int]]()
    var treeVisibility = [[Bool]]()

    lines.forEach { line in
        let a = Array(line)
        trees.append(a.map { Int(String($0))! })
        treeVisibility.append(a.map { _ in true })
    }
    
    for i in 1..<trees.count-1 {
        for j in 1..<trees[0].count-1 {
            treeVisibility[i][j] = isVisible(i: i, j: j, trees: trees, treeVisibility: treeVisibility)
        }
    }
    
    let visibleTrees = treeVisibility.flatMap { $0 }.reduce(into: 0) { partialResult, current in
        partialResult += current ? 1 : 0
    }
    
    print(visibleTrees)
}

func isVisible(i: Int, j: Int, trees: [[Int]], treeVisibility: [[Bool]]) -> Bool {
    let tree = trees[i][j]
    var visible = true
    for k in 0..<i {
        if trees[k][j] >= tree {
            visible = false
            continue
        }
    }
    if visible { return true }
    
    visible = true
    for k in i+1..<trees.count {
        if trees[k][j] >= tree {
            visible = false
            continue
        }
    }
    if visible { return true }
    
    visible = true
    for k in 0..<j {
        if trees[i][k] >= tree {
            visible = false
            continue
        }
    }
    if visible { return true }
    
    visible = true
    for k in j+1..<trees.count {
        if trees[i][k] >= tree {
            visible = false
            continue
        }
    }
    
    return visible
}

let startTime = Date()
main()
let timeElapsed = Date().timeIntervalSince(startTime) * 1000
print("elapsed: \(timeElapsed)ms")
