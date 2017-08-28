//
//  ShrineCollectionViewCell.swift
//  ShrineClone
//
//  Created by Aidan Aden on 14/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit
import SwiftyJSON


class ShrineCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    var avatar = UIImageView()
    
    fileprivate var label = UILabel()
    fileprivate var labelAvatar = UILabel()
    fileprivate var labelPrice = UILabel()
    fileprivate var shrineInkOverlay = ShrineInkOverlay()
    fileprivate var cellContent = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellContent.frame = bounds
        cellContent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cellContent.backgroundColor = .white
        cellContent.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        cellContent.addSubview(imageView)
        
        avatar.layer.cornerRadius = 12
        avatar.backgroundColor = .lightGray
        avatar.clipsToBounds = true
        cellContent.addSubview(avatar)
        
        labelAvatar.lineBreakMode = .byWordWrapping
        labelAvatar.numberOfLines = 1
        labelAvatar.font = UIFont(name: "Helvetica", size: 14)
        labelAvatar.textColor = .gray
        cellContent.addSubview(labelAvatar)
        
        labelPrice.lineBreakMode = .byWordWrapping
        labelPrice.font = UIFont(name: "Helvetica", size: 16)
        cellContent.addSubview(labelPrice)
        
        shrineInkOverlay.frame = bounds
        shrineInkOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cellContent.addSubview(shrineInkOverlay)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(cellContent)
        
        // set up frames for views
        let imagePad: CGFloat = 40
        imageView.frame = CGRect(x: imagePad, y: imagePad, width: frame.width - imagePad * 2, height: frame.height - imagePad * 2 - 10)
        let avatarDim: CGFloat = 24
        avatar.frame = CGRect(x: 10, y: frame.height - avatarDim - 10, width: avatarDim, height: avatarDim)
        labelAvatar.frame = CGRect(x: 15 + avatarDim, y: frame.size.height - 30, width: frame.width, height: 16)
        labelPrice.sizeToFit()
        labelPrice.frame = CGRect(x: frame.width - labelPrice.frame.size.width - 10, y: 10, width: labelPrice.frame.size.width, height: labelPrice.frame.size.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        avatar.image = nil
    }
    
    func populateCell(_ title: String, imageName: String, avatar: String, shopTitle: String, price: String) {
        
        labelAvatar.text = shopTitle
        labelPrice.text = price
        
        let urlString = ShrineData.baseURL + imageName
        if let url = URL(string: urlString) {
            DispatchQueue.main.async {
                self.imageView.sd_setImage(with: url)
            }
        }
        
        let avatarUrl = ShrineData.baseURL + avatar
        if let avatarURL = URL(string: avatarUrl) {
            DispatchQueue.main.async {
                self.avatar.sd_setImage(with: avatarURL)
            }
        }
    }
}







