//
//  ArrayCollectionViewController.swift
//  MachanismsOOP
//
//  Created by TimFerens on 10.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import UIKit

protocol ArrayCollectionControllerDelegate {
    func getDeterminant(_ controller: ArrayCollectionViewController, determinant: ResultDeterminant, array: [[Int]])
}

class ArrayCollectionViewController: UICollectionViewController {
    
    var delegate: ArrayCollectionControllerDelegate? //делегатом будет тот, кто выполняет данный протокол
    var matrixVariable = MatrixVariables()
    var arrayOfCell = [CollectionViewCell?]()
    
    @IBAction func cancel(_ sender: Any) {
        let workWithMatrix = WorkWithMatrix()
        matrixVariable.arrayOfElements = filingArray(array: arrayOfCell, size: matrixVariable.size)
        delegate?.getDeterminant(self, determinant: workWithMatrix.determinantArray(array: matrixVariable.arrayOfElements, sizeMatrix: matrixVariable.size), array: matrixVariable.arrayOfElements) //делегируем
    }
    //перед созданием
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        arrayOfCell.append(cell)
        cell.elementMatrixField.text = "\(matrixVariable.arrayOfElements[indexPath.row / matrixVariable.size][indexPath.row % matrixVariable.size])"

        return cell
    }
    
    func filingArray(array arrayOfCell: [CollectionViewCell?], size: Int) -> [[Int]]{
        var array: [[Int]] = []
        for row in 0..<(size) {
            array.append([Int]())
            for coulum in 0..<size {
                let element: Int = Int(arrayOfCell[coulum + row * size]?.elementMatrixField.text ?? "0") ?? 0
                array[row].append(element)
            }
        }
        return array
    }
}
