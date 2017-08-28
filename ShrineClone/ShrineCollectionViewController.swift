//
//  ShrineCollectionViewController.swift
//  ShrineClone
//
//  Created by Aidan Aden on 14/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit
import MaterialComponents

class ShrineCollectionViewController: UICollectionViewController {
    
    var header: MDCFlexibleHeaderViewController!
    fileprivate let shrineData: ShrineData
    fileprivate var headerContentView = ShrineHeaderContentView(frame: CGRect.zero)
    
    private let cellId = "ShrineCollectionViewCell"
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        self.shrineData = ShrineData()
        self.shrineData.readJSON()
        super.init(collectionViewLayout: layout)
        self.collectionView?.backgroundColor = UIColor(white: 0.97, alpha: 1)
        self.collectionView?.register(ShrineCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shrineData.titles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShrineCollectionViewCell
        let itemNum: NSInteger = indexPath.row
        
        let title = shrineData.titles[itemNum] as! String
        let imageName = shrineData.imageNames[itemNum] as! String
        let avatar = shrineData.avatars[itemNum] as! String
        let shopTitle = shrineData.shopTitles[itemNum] as! String
        let price = shrineData.prices[itemNum] as! String
        
        cell.populateCell(title, imageName: imageName, avatar: avatar, shopTitle: shopTitle, price: price)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let cellWidth = floor((self.view.frame.size.width - (2 * 5)) / 2) - (2 * 5)
        let cellHeight = cellWidth * 1.2
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header.scrollViewDidScroll(scrollView)
        
        let scrollContentOffsetY = scrollView.contentOffset.y
        let duration = 0.5
        var opacity: CGFloat = 1
        var logoTextImageOpacity: CGFloat = 0
        
        if scrollContentOffsetY > -240 {
            opacity = 0
            logoTextImageOpacity = 1
        }
        
        UIView.animate(withDuration: duration, animations: {
            self.headerContentView.scrollView.alpha = opacity
            self.headerContentView.pageController.alpha = opacity
            self.headerContentView.logoImageView.alpha = opacity
            self.headerContentView.logoTextImageView.alpha = logoTextImageOpacity
        })
    }
    
    func sizeHeaderView() {
        let headerView = header.headerView
        let bounds = UIScreen.main.bounds
        
        if bounds.size.width < bounds.size.height {
            headerView.maximumHeight = 440
        } else {
            headerView.maximumHeight = 72
        }
        headerView.minimumHeight = 72
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        sizeHeaderView()
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sizeHeaderView()
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func setupHeaderView() {
        let headerView = header.headerView
        headerView.trackingScrollView = collectionView
        headerView.maximumHeight = 440
        headerView.minimumHeight = 72
        headerView.backgroundColor = .white
        headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        headerContentView.frame = headerView.frame
        headerContentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        headerView.addSubview(headerContentView)
    }
    
    
}













