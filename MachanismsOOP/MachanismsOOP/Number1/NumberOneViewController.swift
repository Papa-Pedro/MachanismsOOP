//
//  NumberOneViewController.swift
//  MachanismsOOP
//
//  Created by TimFerens on 10.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import UIKit

class NumberOneViewController: UIViewController, GetDeterminantDelegate {
    func getDeterminantCollectionViewController(_ controller: ArrayCollectionViewController, _ determinant: ResultDeterminant) {
        dismiss(animated: true, completion: nil)
        titulDeterminantLabel.isHidden = false
        switch determinant {
        case .overflow(let messange):
            determinantLabel.text = messange
        case .result(let determinantFinish):
            determinantLabel.text = ("\(determinantFinish)")
        }
        sizeMatrixField.text = "\(matrixVariables.size)"
    }
    
    var matrixVariables = MatrixVariables()
    var workWithMatrix = WorkWithMatrix()
    
    // MARK: - Outlet
    @IBOutlet weak var titulDeterminantLabel: UILabel!
    @IBOutlet weak var determinantLabel: UILabel!
    @IBOutlet weak var sizeMatrixLabel: UILabel!
    @IBOutlet weak var sizeMatrixField: UITextField!
    @IBOutlet weak var inputSizeButton: UIButton!
    // MARK: - Actioon
    @IBAction func sizeMatrixField(_ sender: Any) {
        sizeMatrixField.text = ""
    }
    @IBAction func inputSizeButton(_ sender: UIButton) {
        if let size: Int = Int(sizeMatrixField.text ?? "") {
            switch size {
            case 1..<6:
                matrixVariables.size = size
                //matrixVariables.arrayOfElements = workWithMatrix.fillingRandomElement(size: size, borderAmount: 40)
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
            destinationVC.matrixVariable.size = matrixVariables.size
            destinationVC.matrixVariable.arrayOfElements = matrixVariables.arrayOfElements
            destinationVC.delegate = self //говорим, я буду делегатом от destinationVC
        }
    }
}

