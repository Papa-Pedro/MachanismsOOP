//
//  ArrayCollectionViewController.swift
//  MachanismsOOP
//
//  Created by TimFerens on 10.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import UIKit

protocol GetDeterminantDelegate {
    func getDeterminantCollectionViewController(_ controller: ArrayCollectionViewController, _ determinant: Int)
}

struct WorkWithMatrix {
    
    var matrixVariable = MatrixVariables()
    var determinant: Int
    
    init (size matrixVariable: MatrixVariables, _ determinant: Int){
        self.matrixVariable = matrixVariable
        self.determinant = determinant
    }

    mutating func determinantArray(_ arrayFunc: [[Int]], _ sizeMatrix: Int) -> Int {
        var sign = 1
        var minorArray: [[Int]] = []
        switch sizeMatrix {
        case 1:
            return arrayFunc[0][0]
        case 2:
            return  (arrayFunc[0][0] * arrayFunc[1][1] - arrayFunc[1][0] * arrayFunc[0][1])
        default:
            determinant = 0
            for i in 0..<sizeMatrix {
                minorArray.removeAll()
                var counter = 0
                for row in 0..<sizeMatrix {
                    if row != i {
                        minorArray.append([Int]())
                        for column in 1..<sizeMatrix {
                            minorArray[counter].append(arrayFunc[row][column])
                        }
                        counter += 1
                    }
                }
                determinant = determinant + arrayFunc[i][0] * sign * determinantArray(minorArray, sizeMatrix-1)
                sign *= -1
            }
            return determinant
        }
        
    }
    
    
}

class ArrayCollectionViewController: UICollectionViewController {//}, UITextFieldDelegate {
    
    
    var delegate: GetDeterminantDelegate? //делегатом будет тот, кто выполняет данный протокол
    
    var matrixVariable = MatrixVariables()
    var createElementsOfMatrix = CreateElementsOfMatrix()
    
    @IBAction func cancel(_ sender: Any) {
        var workWithMatrix = WorkWithMatrix(size: matrixVariable, 0)
        matrixVariable.determinant = workWithMatrix.determinantArray(createElementsOfMatrix.filingArray(array: matrixVariable.arrayOfCell, size: matrixVariable.size), matrixVariable.size)
        delegate?.getDeterminantCollectionViewController(self, matrixVariable.determinant) //делегируем
    }
    //перед созданием
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //matrixVariable.arrayOfCell = createElementsOfMatrix.createEmptyArreay(size: matrixVariable.size)
        let layout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        //размер экрана
        let width = Float(self.collectionView!.frame.width)
        //отступ между ячейками
        layout.minimumInteritemSpacing = 10
        //размер ячеек
        layout.itemSize.width = CGFloat(width / Float(matrixVariable.size + 1) - 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matrixVariable.size * matrixVariable.size
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        matrixVariable.arrayOfCell.append(cell)//[indexPath.row] = cell
            if indexPath.row != 0 {
                cell.elementMatrixField.text = "\(Int(arc4random_uniform(40)) - 20)"
            } else {
                cell.elementMatrixField.text = "\(Int(arc4random_uniform(40)) - 20)"
            }

        return cell
    }
    
}
