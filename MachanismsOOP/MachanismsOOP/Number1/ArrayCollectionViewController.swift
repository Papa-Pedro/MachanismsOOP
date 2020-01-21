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
    
    var size: Int
    var determinant: Int
    
    init (_ size: Int, _ determinant: Int, _ s: Int){
        self.size = size
        self.determinant = determinant
    }

    
    func arrayFiling(array arrayOfCell: [CollectionViewCell?] ) -> [[Int]] {
        var array: [[Int]] = []
        for row in 0..<(size) {
            array.append([Int]())
            for coulum in 0..<size {
                var element: Int = Int(arrayOfCell[coulum + row * size]?.elementMatrixField.text ?? "0") ?? 0
                if element > 5000 && element < -5000 { element = 0 }
                array[row].append(element)
            }
        }
        return array
    }
    
    mutating func determinantArray(_ arrayFunc: [[Int]], _ sizeMatrix: Int) -> Int {
        var s = 1
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
                determinant = determinant + arrayFunc[i][0] * s * determinantArray(minorArray, sizeMatrix-1)
                s *= -1
            }
            return determinant
        }
        
    }
    
    
}

class ArrayCollectionViewController: UICollectionViewController {//}, UITextFieldDelegate {
    
    var delegate: GetDeterminantDelegate? //делегатом будет тот, кто выполняет данный протокол
    
    var size: Int = 0
    var arrayOfCell = [CollectionViewCell?]()
    var determinant: Int = 0
    var s = 1
    
    @IBAction func cancel(_ sender: Any) {
        var workWithMatrix = WorkWithMatrix(size, 0, 1)
        determinant = workWithMatrix.determinantArray(workWithMatrix.arrayFiling(array: arrayOfCell), size)
        delegate?.getDeterminantCollectionViewController(self, determinant) //делегируем 
    }
    //перед созданием
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emptyCreateArray()
        let layout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        //размер экрана
        let width = Float(self.collectionView!.frame.width)
        //отступ между ячейками
        layout.minimumInteritemSpacing = 10
        //размер ячеек
        layout.itemSize.width = CGFloat(width / Float(size + 1) - 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return size*size
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        arrayOfCell[indexPath.row] = cell
            if indexPath.row != 0 {
                cell.elementMatrixField.text = "\(Int(arc4random_uniform(40)) - 20)"
            } else {
                cell.elementMatrixField.text = "\(Int(arc4random_uniform(40)) - 20)"
            }

        return cell
    }
    
    func emptyCreateArray() {
        for _ in 0..<(size * size) {
            arrayOfCell.append(nil)
        }
    }
    
}
