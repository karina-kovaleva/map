//
//  ListViewController.swift
//  ATMs
//
//  Created by Karina Kovaleva on 27.12.22.
//

import UIKit

class ListViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView()
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
    }
}
