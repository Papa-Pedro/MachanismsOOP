//
//  NumberOneViewController.swift
//  MachanismsOOP
//
//  Created by TimFerens on 10.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import UIKit

class NumberOneViewController: UIViewController, GetDeterminantDelegate {
    
    func getDeterminantCollectionViewController(_ controller: ArrayCollectionViewController, _ determinant: Int) {
        dismiss(animated: true, completion: nil)
        titulDeterminantLabel.isHidden = false
        determinantLabel.text = "\(determinant)"
        sizeMatrixField.text = "\(size)"
    }
    
    
    var size: Int = 0
    var determinant: Int?
    var array: [[Int]] = []
    
    
    @IBOutlet weak var titulDeterminantLabel: UILabel!
    @IBOutlet weak var determinantLabel: UILabel!
    @IBOutlet weak var sizeMatrixLabel: UILabel!
    @IBOutlet weak var sizeMatrixField: UITextField!
    @IBAction func sizeMatrixField(_ sender: Any) {
        sizeMatrixField.text = ""
    }
    @IBOutlet weak var inputSizeButton: UIButton!
    
    @IBAction func inputSizeButton(_ sender: UIButton) {
        if let size1: Int = Int(sizeMatrixField.text ?? "") {
            switch size1 {
            case 1..<5:
                size = size1
                performSegue(withIdentifier: "ShowSegue", sender: self)
            case ...0:
                sizeMatrixLabel.text = "Не бывает таких матриц"
            default:
                sizeMatrixLabel.text = "Большой размер для тестового задания"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            titulDeterminantLabel.isHidden = true
            determinantLabel.text = ""
            sizeMatrixField.text = "___"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSegue"
        {
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.topViewController as! ArrayCollectionViewController
            destinationVC.size = size
            destinationVC.delegate = self //говорим, я буду делегатом от destinationVC
        }
    }
}

