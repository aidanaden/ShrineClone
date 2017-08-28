//
//  ShrineHeaderPage.swift
//  ShrineClone
//
//  Created by Aidan Aden on 14/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit
import SDWebImage


struct ShrineHeaderPage {
    
    let textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
    let fontAbril = UIFont(name: "AbrilFatface-Regular", size: 36)
    let fontHelvetica = UIFont(name: "Helvetica", size: 14)
    let cyanBoxColor = UIColor(red: 0.19, green: 0.94, blue: 0.94, alpha: 1)
    let descColor = UIColor(white: 0.54, alpha: 1)
    let descString = "Leave the tunnel and the rain is fallin amazing things happen when you wait Xd"
    
    var page: UIView
    var label: UILabel
    var labelDesc: UILabel
    var imageView: UIImageView
    var imageName: String
    var description: String
    var cynBox: UIView
    
    init(page: UIView, label: UILabel, labelDesc: UILabel, imageName: String, imageView: UIImageView, description: String, cynBox: UIView) {
        
        self.page = page
        self.label = label
        self.labelDesc = labelDesc
        self.imageName = imageName
        self.imageView = imageView
        self.description = description
        self.cynBox = cynBox
        
        // initialize ImageView
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = .flexibleHeight
        page.addSubview(imageView)
        if let url = URL(string: ShrineData.baseURL + imageName) {
            imageView.sd_setImage(with: url)
            imageView.setNeedsDisplay()
        }
        
        // initialize bigger label
        label.font = fontAbril
        label.textColor = textColor
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.attributedText = attributedString(description, lineHeightMultiple: 0.8)
        label.sizeToFit()
        page.addSubview(label)
        
        // initialize smaller label
        labelDesc.font = fontHelvetica
        labelDesc.textColor = descColor
        labelDesc.lineBreakMode = .byWordWrapping
        labelDesc.numberOfLines = 3
        labelDesc.autoresizingMask = .flexibleWidth
        labelDesc.attributedText = attributedString(descString, lineHeightMultiple: 1.2)
        page.addSubview(labelDesc)
        
        cynBox.backgroundColor = cyanBoxColor
        page.addSubview(cynBox)
        
        // initialize ink overlay view
        let inkOverlay = ShrineInkOverlay(frame: page.bounds)
        inkOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        page.addSubview(inkOverlay)
        
    }
    
    // attributed string convenience function
    func attributedString(_ string: String,
                          lineHeightMultiple: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let attrString = NSMutableAttributedString(string: string)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle,
                                range:NSRange(location: 0, length: attrString.length))
        return attrString
    }
    
    
}





