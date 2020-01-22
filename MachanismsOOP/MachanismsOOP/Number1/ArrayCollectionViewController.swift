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

class ArrayCollectionViewController: UICollectionViewController {
    
    var arrayOfCell = [CollectionViewCell?]()
    
    var delegate: GetDeterminantDelegate? //делегатом будет тот, кто выполняет данный протокол
    var matrixVariable = MatrixVariables()
    
    @IBAction func cancel(_ sender: Any) {
        let workWithMatrix = WorkWithMatrix()
        let collectionViewCell = CollectionViewCell()
        matrixVariable.arrayOfElements = collectionViewCell.filingArray(array: arrayOfCell, size: matrixVariable.size)
        matrixVariable.determinant = workWithMatrix.determinantArray(array: matrixVariable.arrayOfElements, sizeMatrix: matrixVariable.size)
        delegate?.getDeterminantCollectionViewController(self, matrixVariable.determinant) //делегируем
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
            if indexPath.row != 0 {
                cell.elementMatrixField.text = "\(Int(arc4random_uniform(40)) - 20)"
            } else {
                cell.elementMatrixField.text = "\(Int(arc4random_uniform(40)) - 20)"
            }

        return cell
    }
    
    
    
}
