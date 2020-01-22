//
//  WorkWithMatrix.swift
//  MachanismsOOP
//
//  Created by TimFerens on 22.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import Foundation

class WorkWithMatrix {
    
    func determinantArray(array: [[Int]], sizeMatrix: Int) -> Int {
        
        var sign = 1
        var minorArray: [[Int]] = []
        let matrixVariable = MatrixVariables()
        
        switch sizeMatrix {
        case 1:
            return array[0][0]
            
        case 2:
            return array[0][0] * array[1][1] - array[1][0] * array[0][1]
            
        default:
            matrixVariable.determinant = 0
            
            for i in 0..<sizeMatrix {
                minorArray.removeAll()
                var counter = 0
                for row in 0..<sizeMatrix {
                    if row != i {
                        minorArray.append([Int]())
                        for column in 1..<sizeMatrix {
                            minorArray[counter].append(array[row][column])
                        }
                        counter += 1
                    }
                }
                matrixVariable.determinant = matrixVariable.determinant + array[i][0] * sign * determinantArray(array: minorArray, sizeMatrix: sizeMatrix-1)
                sign *= -1
            }
            return matrixVariable.determinant
        }
    }
    
}
