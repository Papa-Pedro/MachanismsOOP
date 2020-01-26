//
//  ArrayElements.swift
//  MachanismsOOP
//
//  Created by TimFerens on 26.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import Foundation

class ArrayElements {
    
    func createRandomArray(size: Int) -> [[Int]] {
        var array = [[Int]]()
        for row in 0..<size {
            array.append([Int]())
            for _ in 0..<size {
                array[row].append(Int(arc4random_uniform(40)) - 20)
            }
        }
        return array
    }
    
}
