//
//  ArrayCollectionViewController.swift
//  MachanismsOOP
//
//  Created by TimFerens on 10.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

struct WorkWithMatrix {
    
    var size = 0
    
    func arrayFiling(array arrayOfCell: [CollectionViewCell?] ) -> [[Int]] {
        var array: [[Int]] = []
        for row in 0..<(size) {
            array.append([Int]())
            for coulum in 0..<size {
                var element: Int = Int(arrayOfCell[coulum + row * size]?.elementMatrixField.text ?? "0") ?? 0
                if element > 10000 && element < -10000 { element = 0 }
                array[row].append(element)
            }
        }
        return array
    }
}

import UIKit

class ArrayCollectionViewController: UICollectionViewController {//}, UITextFieldDelegate {
    
    var workWithMatrix = WorkWithMatrix()
    
    var size: Int = 0
    var array: [[Int]] = []
    var arrayOfCell = [CollectionViewCell?]()
    var determinant: Int = 0
    var s = -1
    
    @IBAction func cancel(_ sender: Any) {
        workWithMatrix.size = size
        determinant = 0
        s = -1
        determinant = determinantArray(workWithMatrix.arrayFiling(array: arrayOfCell), size)
        performSegue(withIdentifier: "BackSegue", sender: self)
    }

    //перед созданием
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //workWithMatrix.size = size
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackSegue" {
            if let destinationVC = segue.destination as? NumberOneViewController {
                destinationVC.determinant = determinant
                destinationVC.size = size
            }
        }
    }
    
    func emptyCreateArray() {
        for _ in 0..<(size * size) {
            arrayOfCell.append(nil)
        }
    }
    
    func determinantArray(_ arrayFunc: [[Int]], _ sizeMatrix: Int) -> Int {
        var minorArray: [[Int]] = []
        if sizeMatrix == 1 {
            determinant = arrayFunc[0][0]
            return arrayFunc[0][0]
        }
        if sizeMatrix == 2 {
            determinant = arrayFunc[0][0] * arrayFunc[1][1] - arrayFunc[1][0] * arrayFunc[0][1]
            return arrayFunc[0][0] * arrayFunc[1][1] - arrayFunc[1][0] * arrayFunc[0][1]
        }
        for i in 0..<sizeMatrix {
            s *= -1
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
        }
        return determinant
    }
    
}
