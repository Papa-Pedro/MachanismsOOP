//
//  createElementsOfMatrix.swift
//  MachanismsOOP
//
//  Created by TimFerens on 22.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import Foundation

class CreateElementsOfMatrix {
    
    func filingArray(array arrayOfCell: [CollectionViewCell?], size: Int) -> [[Int]]{
        var array: [[Int]] = []
        for row in 0..<(size) {
            array.append([Int]())
            for coulum in 0..<size {
                var element: Int = Int(arrayOfCell[coulum + row * size]?.elementMatrixField.text ?? "0") ?? 0
                if element > 5000 && element < -5000 { element = 0 }
                array[row].append(element)
            }
        }
        return array
    }
    
}
