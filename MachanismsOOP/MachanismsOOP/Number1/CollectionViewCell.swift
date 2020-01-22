//
//  UICollectionViewCell.swift
//  MachanismsOOP
//
//  Created by TimFerens on 10.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var matrixVariable = MatrixVariables()
    
    @IBOutlet weak var elementMatrixField: UITextField!
    @IBAction func elementMatrixField(_ sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func elementMatrixEndField(_ sender: UITextField) {
        guard let element: Int = Int(sender.text ?? ""), (element < matrixVariable.maxElement && element > matrixVariable.minElement)  else {
            sender.text = "0"
            return
        }
    }
    
    func filingArray(array arrayOfCell: [CollectionViewCell?], size: Int) -> [[Int]]{
        var array: [[Int]] = []
        for row in 0..<(size) {
            array.append([Int]())
            for coulum in 0..<size {
                var element: Int = Int(arrayOfCell[coulum + row * size]?.elementMatrixField.text ?? "0") ?? 0
                if element > matrixVariable.maxElement && element < matrixVariable.minElement { element = 0 }
                array[row].append(element)
            }
        }
        return array
    }
    
    
}
