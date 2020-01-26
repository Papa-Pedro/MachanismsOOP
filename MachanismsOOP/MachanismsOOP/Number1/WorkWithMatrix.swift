//
//  WorkWithMatrix.swift
//  MachanismsOOP
//
//  Created by TimFerens on 22.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import UIKit

class WorkWithMatrix {
    
    func determinantArray(array: [[Int]], sizeMatrix: Int) -> ResultDeterminant {
        
        var sign = 1
        var minorArray: [[Int]] = []
        let matrixVariable = MatrixVariables()
        if matrixVariable.determinant == nil {
            return ResultDeterminant.overflow("Слишком большой")
        }
        switch sizeMatrix {
        case 1:
            return ResultDeterminant.result(array[0][0])
        case 2:
            let resultMultiPlus = array[0][0].multipliedReportingOverflow(by: array[1][1])
            let resultMultiMinus = array[1][0].multipliedReportingOverflow(by: array[0][1])
            if resultMultiPlus.overflow == false && resultMultiMinus.overflow == false {
                let resultSubstract = resultMultiPlus.partialValue.subtractingReportingOverflow(resultMultiMinus.partialValue)
                if resultSubstract.overflow == false {
                    return ResultDeterminant.result(resultSubstract.partialValue)
                }
            }
            return ResultDeterminant.overflow("Слишком большой")
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
                //подсчет минора (переполнение)
                let resultNextStep = determinantArray(array: minorArray, sizeMatrix: sizeMatrix-1)
                switch resultNextStep {
                case .overflow:
                    matrixVariable.determinant = nil
                    return resultNextStep
                case .result (let determinant):
                    let resultMinor = determinant.multipliedReportingOverflow(by: array[i][0] * sign)
                    if resultMinor.overflow == false {
                        let result = resultMinor.partialValue.addingReportingOverflow(matrixVariable.determinant!)
                        if result.overflow == false {
                            matrixVariable.determinant = result.partialValue
                            sign *= -1
                        } else {
                            matrixVariable.determinant = nil
                            return ResultDeterminant.overflow("Cлишком большой!!")
                        }
                    } else {
                        matrixVariable.determinant = nil
                        return ResultDeterminant.overflow("Cлишком большой!")
                    }
                    return ResultDeterminant.result(matrixVariable.determinant!)
                }
            }
            return ResultDeterminant.result(matrixVariable.determinant!)
        }
    }
}
