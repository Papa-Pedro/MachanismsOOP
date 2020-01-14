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
    var determinant: Int = 0
    var s = -1
    
    @IBAction func cancel(_ sender: Any) {
        performSegue(withIdentifier: "BackSegue", sender: self)
    }
    //не обязательно использовать этот метод, он нужен что бы выполнение было перед созданием
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrayFiling()
        print(determinantArray(array, size))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return size*size
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if indexPath.row != 0 {
            cell.elementMatrixLabel.text = "\(array[indexPath.row / size][indexPath.row % size])"
        } else {
            cell.elementMatrixLabel.text = "\(array[0][0])"
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackSegue" {
            if let destinationVC = segue.destination as? ViewController {
                destinationVC.determinant = determinant
                destinationVC.size = size
            }
        }
    }
    
    func arrayFiling() {
        for row in 0..<size {
            array.append([Int]())
            for column in 0..<size {
                array[row].append(row+column)
            }
        }
    }
    
    func determinantArray(_ arrayFunc: [[Int]], _ sizeMatrix: Int) -> Int {
        if sizeMatrix == 1 { return arrayFunc[0][0] }
        if sizeMatrix == 2 { return arrayFunc[0][0] * arrayFunc[1][1] - arrayFunc[1][0] * arrayFunc[0][1] }
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
