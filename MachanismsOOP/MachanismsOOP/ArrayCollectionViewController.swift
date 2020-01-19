//
//  ArrayCollectionViewController.swift
//  MachanismsOOP
//
//  Created by TimFerens on 10.01.20.
//  Copyright © 2020 TimFerens. All rights reserved.
//

import UIKit

class ArrayCollectionViewController: UICollectionViewController {//}, UITextFieldDelegate {
    
    var size: Int = 0
    var array: [[Int]] = []
    var minorArray: [[Int]] = []
    var arrayOfElement = [CollectionViewCell?]()
    var determinant: Int = 0
    var s = -1
    var usedBegin = true
    
    @IBAction func cancel(_ sender: Any) {
        print(determinantArray(array, size))
        for row in 0..<size {
            for coulum in 0..<size {
                if let element: Int = Int(arrayOfElement[coulum + row * size]?.elementMatrixField.text ?? "") {
                    if element > 10000 && element < -10000 {
                        array[row][coulum] = 0
                    } else {
                        array[row][coulum] = element
                    }
                } else { array[row][coulum] = 0 }
            }
        }
        determinant = 0
        s = -1
        determinant = determinantArray(array, size)
        performSegue(withIdentifier: "BackSegue", sender: self)
    }

    //перед созданием
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        arrayFiling()
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
        arrayOfElement[indexPath.row] = cell
            if indexPath.row != 0 {
                if usedBegin == false {
                    array[indexPath.row / size][indexPath.row % size] = Int(cell.elementMatrixField.text!)!
                } else {
                    cell.elementMatrixField.text = "\(array[indexPath.row / size][indexPath.row % size])"
                }
            } else {
                    cell.elementMatrixField.text = "\(array[0][0])"
            }

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackSegue" {
            //print(determinantArray(array, size))
            if let destinationVC = segue.destination as? ViewController {
                destinationVC.determinant = determinant
                destinationVC.size = size
            }
        }
    }
    
    func emptyCreateArray() {
        for _ in 0..<(size * size) {
            arrayOfElement.append(nil)
        }
    }
    
    func arrayFiling() {
        for row in 0..<(size) {
            array.append([Int]())
            for _ in 0..<size {
                array[row].append(Int(arc4random_uniform(40)) - 20)
            }
        }
    }
    
    func determinantArray(_ arrayFunc: [[Int]], _ sizeMatrix: Int) -> Int {
        if sizeMatrix == 1 {
            determinant = arrayFunc[0][0]
            return arrayFunc[0][0]
        }
        if sizeMatrix == 2 {
            determinant = arrayFunc[0][0] * arrayFunc[1][1] - arrayFunc[1][0] * arrayFunc[0][1]
            return arrayFunc[0][0] * arrayFunc[1][1] - arrayFunc[1][0] * arrayFunc[0][1]
        }
        //var counter = 0
        for i in 0..<sizeMatrix {
            s *= -1
            var counter = 0
            minorArray.removeAll()
            //size -= 1
            for row in 0..<sizeMatrix {
                if row != i {
                    minorArray.append([Int]())
                    for column in 1..<sizeMatrix {
                    minorArray[counter].append(arrayFunc[row][column])
                    }
                    counter += 1
                }
            }
            determinant = determinant + array[i][0] * s * determinantArray(minorArray, sizeMatrix-1)
        }
        return determinant
    }
    
}
