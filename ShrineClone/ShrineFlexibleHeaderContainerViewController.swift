//
//  ViewController.swift
//  ShrineClone
//
//  Created by Aidan Aden on 14/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit
import MaterialComponents

class ShrineFlexibleHeaderContainerViewController: MDCFlexibleHeaderContainerViewController {

    init() {
        
        let layout = UICollectionViewFlowLayout()
        let sectionInset: CGFloat = 10.0
        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        
        let collectionVC = ShrineCollectionViewController(collectionViewLayout: layout)
        super.init(contentViewController: collectionVC)
        
        collectionVC.header = self.headerViewController
        collectionVC.setupHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}

