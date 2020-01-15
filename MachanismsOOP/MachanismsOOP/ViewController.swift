//
//  ViewController.swift
//  MachanismsOOP
//
//  Created by TimFerens on 10.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var size: Int = 0
    var determinant: Int?
    var array: [[Int]] = []
    
    @IBOutlet weak var determinantLabel: UILabel!
    @IBOutlet weak var sizeMatrixLabel: UILabel!
    @IBOutlet weak var sizeMatrixField: UITextField!
    @IBAction func sizeMatrixField(_ sender: Any) {
        sizeMatrixField.text = ""
    }
    @IBOutlet weak var inputSizeButton: UIButton!
    
    @IBAction func inputSizeButton(_ sender: UIButton) {
        if let size1: Int = Int(sizeMatrixField.text ?? "") {
            if size1 < 5 {
                size = size1
                performSegue(withIdentifier: "ShowSegue", sender: self)
            }
            else {
                sizeMatrixLabel.text = "Большой размер для тестового задания"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if determinant != nil {
            determinantLabel.text = "\(String(describing: determinant!) )"
            sizeMatrixField.text = "\(size)"
        } else {
            determinantLabel.text = ""
            sizeMatrixField.text = "Введите размер"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSegue"
        {
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.topViewController as! ArrayCollectionViewController
            destinationVC.size = size
        }
    }
}

