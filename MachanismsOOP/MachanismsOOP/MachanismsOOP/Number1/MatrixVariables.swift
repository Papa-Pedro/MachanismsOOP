//
//  MatrixVariables.swift
//  MachanismsOOP
//
//  Created by TimFerens on 21.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import Foundation

class MatrixVariables {
    var size: Int = 0
    var arrayOfElements = [[Int]]()
    var determinant: Int? = 0
}

enum ResultDeterminant {
    case result(Int)
    case overflow(String)
}
