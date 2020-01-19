//
//  UICollectionViewCell.swift
//  MachanismsOOP
//
//  Created by TimFerens on 10.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var elementMatrixField: UITextField!
    
    @IBAction func elementMatrixField(_ sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func elementMatrixEndField(_ sender: UITextField) {
        if let element: Int = Int(sender.text ?? "") {
            if element < 10000 && element > -10000 {
            } else { sender.text = "0" }
        } else { sender.text = "0" }
    }
    
}
