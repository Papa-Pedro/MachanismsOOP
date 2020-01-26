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
        guard let _: Int = Int(sender.text ?? "") else {
            sender.text = "0"
            return
        }
    }

}
