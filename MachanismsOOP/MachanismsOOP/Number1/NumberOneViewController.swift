//
//  NumberOneViewController.swift
//  MachanismsOOP
//
//  Created by TimFerens on 10.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

//дописать именование кнопок и добавить действие на 2 кнопку поправить лайауты

import UIKit

class NumberOneViewController: UIViewController {
    
    var matrixVariables = MatrixVariables()
    var workWithMatrix = WorkWithMatrix()
    // MARK: - Outlet
    @IBOutlet weak var titulDeterminantLabel: UILabel!
    @IBOutlet weak var determinantLabel: UILabel!
    @IBOutlet weak var sizeMatrixLabel: UILabel!
    @IBOutlet weak var sizeMatrixField: UITextField!
    @IBOutlet weak var createRandomButton: UIButton!
    @IBOutlet weak var lookMatrixButton: UIButton!
    // MARK: - Actioon
    @IBAction func sizeMatrixField(_ sender: Any) {
        sizeMatrixField.text = ""
    }
    //написать
    @IBAction func createRandomButton(_ sender: UIButton) {
        let arrayElements = ArrayElements()
        if let size: Int = Int(sizeMatrixField.text ?? "") {
            switch size {
            case 1..<6:
                matrixVariables.arrayOfElements = arrayElements.createRandomArray(size: size)
                matrixVariables.size = size
                performSegue(withIdentifier: "ShowSegue", sender: self)
            case ...0:
                sizeMatrixLabel.text = "Не бывает таких матриц"
            default:
                sizeMatrixLabel.text = "Большой размер для тестового задания"
            }
        }
    }
    @IBAction func lookMatrixButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lookMatrixButton.isHidden = true
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

extension NumberOneViewController: ArrayCollectionControllerDelegate {
    
    func getDeterminant(_ controller: ArrayCollectionViewController, determinant: ResultDeterminant, array: [[Int]]) {
        dismiss(animated: true, completion: nil)
        matrixVariables.arrayOfElements = array
        // MARK: - isHidden
        lookMatrixButton.isHidden = false
        titulDeterminantLabel.isHidden = false
        switch determinant {
        case .overflow(let messange):
            determinantLabel.text = messange
        case .result(let determinantFinish):
            determinantLabel.text = ("\(determinantFinish)")
        }
        sizeMatrixField.text = "\(matrixVariables.size)"
    }
}

