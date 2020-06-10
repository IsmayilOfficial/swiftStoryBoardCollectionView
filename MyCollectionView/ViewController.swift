//
//  ViewController.swift
//  MyCollectionView
//
//  Created by Ismayil Tahmazov on 10.06.2020.
//  Copyright © 2020 Ismayil Tahmazov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView?
    
    var colors: [UIColor] = [
    .link,
    .systemGreen,
    .systemBlue,
    .red,
    .systemOrange,
    .black,
    .systemPurple,
    .systemYellow,
    .systemPink
    
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
      
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/3.2 ,
                                 height: view.frame.size.width/3.2)
             layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
             collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        
        view.addSubview(collectionView!)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        
        collectionView?.addGestureRecognizer(gesture)
        
        
        
    }
    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer){
        guard let collectionView = collectionView else {
            return
        }
        switch gesture.state {
        case .began:
            guard  let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else{
                return
            }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
            
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
            
        case .ended:
            collectionView.endInteractiveMovement()
            
            
        default:
            collectionView.cancelInteractiveMovement()
        }
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)-> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/3.2 ,
                      height: view.frame.size.width/3.2)
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item  = colors.remove(at: sourceIndexPath.row)
        colors.insert(item, at: destinationIndexPath.row)
    }
}

