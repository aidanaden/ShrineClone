//
//  ShrineHeaderContentView.swift
//  ShrineClone
//
//  Created by Aidan Aden on 14/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit
import MaterialComponents


class ShrineHeaderContentView: UIView, UIScrollViewDelegate {
    
    var pageController = MDCPageControl()
    var scrollView = UIScrollView()
    var logoImageView = UIImageView(image: #imageLiteral(resourceName: "ShrineLogo"))
    var logoTextImageView = UIImageView(image: #imageLiteral(resourceName: "ShrineTextLogo"))
    
    fileprivate var pages = NSMutableArray()
    fileprivate var label = UILabel()
    fileprivate var labelDesc = UILabel()
    fileprivate var label2 = UILabel()
    fileprivate var labelDesc2 = UILabel()
    fileprivate var label3 = UILabel()
    fileprivate var labelDesc3 = UILabel()
    fileprivate var cyanBox = UIView()
    fileprivate var cyanBox2 = UIView()
    fileprivate var cyanBox3 = UIView()
    fileprivate var imageView = UIImageView()
    fileprivate var imageView2 = UIImageView()
    fileprivate var imageView3 = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        
        let boundsWidth = bounds.width
        let boundsHeight = bounds.height
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(scrollView)
        
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // initialize pages and add on top of scrollview
        for i in 0...2 {
            let boundsOffset = CGFloat(i) * boundsWidth
            let pageFrame = bounds.offsetBy(dx: boundsOffset, dy: 0)
            let page = UIView(frame: pageFrame)
            page.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            page.clipsToBounds = true
            pages.add(page)
            scrollView.addSubview(page)
        }
        
        // initialize page controller
        pageController.numberOfPages = pages.count
        pageController.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let pageControllerSize = pageController.sizeThatFits(bounds.size)
        pageController.frame = CGRect(x: 0, y: boundsHeight - pageControllerSize.height, width: bounds.width, height: pageControllerSize.height)
        pageController.addTarget(self, action: #selector(pageDidChange), for: .valueChanged)
        addSubview(pageController)
        
        addHeaderPages()
        addSubview(logoImageView)
        addSubview(logoTextImageView)
    }
    
    func addHeaderPages() {
        
        _ = ShrineHeaderPage(page: pages[0] as! UIView, label: label, labelDesc: labelDesc, imageName: "chair.png", imageView: imageView, description: "Green \ncomfort chair", cynBox: cyanBox)
        
        _ = ShrineHeaderPage(page: pages[1] as! UIView, label: label2, labelDesc: labelDesc2, imageName: "backpack.png", imageView: imageView2, description: "Best gift for \nthe traveler", cynBox: cyanBox2)
        
        _ = ShrineHeaderPage(page: pages[2] as! UIView, label: label3, labelDesc: labelDesc3, imageName: "heels.png", imageView: imageView3, description: "Better \nwearing heels", cynBox: cyanBox3)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let boundsWidth = bounds.width
        let boundsHeight = bounds.height
        
        // set frame of pages
        for i in 0...pages.count - 1 {
            let boundsLeft = CGFloat(i) * boundsWidth
            let pageFrame = bounds.offsetBy(dx: boundsLeft, dy: 0)
            let page = pages[i] as! UIView
            page.frame = pageFrame
        }
        
        // set page controller frame
        let pageControlSize = pageController.sizeThatFits(bounds.size)
        pageController.frame = CGRect(x: 0, y: boundsHeight - pageControlSize.height, width: boundsWidth, height: pageControlSize.height)
        
        // set scrollView frame and content size (size of width that can be scrolled)
        let scrollWidth: CGFloat = CGFloat(pages.count) * boundsWidth
        scrollView.frame = CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight)
        scrollView.contentSize = CGSize(width: scrollWidth, height: boundsHeight)
        
        // set scroll view offset and logo positions
        let scrollViewOffsetX: CGFloat = CGFloat(pageController.currentPage) * boundsWidth
        scrollView.setContentOffset(CGPoint(x: scrollViewOffsetX, y: 0), animated: true)
        logoImageView.center = CGPoint(x: frame.width / 2, y: 44)
        logoTextImageView.center = CGPoint(x: frame.width / 2, y: 44)
        
        // set up frames and width of labels and description labels
        let labelWidth = CGFloat(250)
        let labelWidthFrame = CGRect(x: frame.size.width - labelWidth, y: 90, width: labelWidth, height: label.frame.size.height)
        
        let labelDescWidth = CGFloat(200)
        let labelDescWidthFrame = CGRect(x: frame.size.width - labelDescWidth - 10, y: 190, width: labelDescWidth, height: 40)
        
        // instantiate label frames
        label.frame = labelWidthFrame
        labelDesc.frame = labelDescWidthFrame
        label2.frame = labelWidthFrame
        labelDesc2.frame = labelDescWidthFrame
        label3.frame = labelWidthFrame
        labelDesc3.frame = labelDescWidthFrame
        
        let cyanBoxFrame = CGRect(x: frame.size.width - 210, y: 180, width: 100, height: 8)
        cyanBox.frame = cyanBoxFrame
        cyanBox2.frame = cyanBoxFrame
        cyanBox3.frame = cyanBoxFrame
        
        imageView.frame = CGRect(x: -180, y: 120, width: 420, height: frame.height)
        imageView2.frame = CGRect(x: -220, y: 110, width: 420, height: frame.height)
        imageView3.frame = CGRect(x: -180, y: 40, width: 420, height: frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageController.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageController.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageController.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func pageDidChange(_ sender: MDCPageControl) {
        var offset = scrollView.contentOffset
        offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width
        scrollView.setContentOffset(offset, animated: true)
    }
    
    
    
    
    
}








