//
//  ViewPagerTableViewB.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 18/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

public final class ViewPagerTabViewB: UIView {
    
    internal enum SetupCondition {
        case fitAllTabs
        case distributeNormally
    }
    
    internal var titleLabel:UILabel?
    
    
    /*--------------------------
     MARK:- Initialization
     ---------------------------*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*--------------------------
     MARK:- Tab Setup
     ---------------------------*/
    
    /**
     Sets up tabview for ViewPager. The type of tabview is automatically obtained from
     the options passed in this function.
     */
    internal func setup(tab:ViewPagerTab, options:ViewPagerOptionsB , condition:SetupCondition) {
        
        switch options.tabType {
            
        case ViewPagerTabType.basic:
            setupBasicTab(condition: condition, options: options, tab: tab)
            
        }
    }
    
    
    /**
     * Creates tab containing only one label with provided options and add it as subview to this view.
     *
     * Case FitAllTabs: Creates a tabview of provided width. Does not consider the padding provided from ViewPagerOptions.
     *
     * Case DistributeNormally: Creates a tabview. Width is calculated from title intrinsic size. Considers the padding
     * provided from options too.
     */
    fileprivate func setupBasicTab(condition:SetupCondition, options:ViewPagerOptionsB, tab:ViewPagerTab) {
        
        switch condition {
            
        case .fitAllTabs:
            
            buildTitleLabel(withOptions: options, text: tab.title)
            titleLabel?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            
        case .distributeNormally:
            
            buildTitleLabel(withOptions: options, text: tab.title)
            
            // Resetting TabView frame again with the new width
            let currentFrame = self.frame
            let labelWidth = titleLabel!.intrinsicContentSize.width + options.tabViewPaddingLeft + options.tabViewPaddingRight
            let newFrame = CGRect(x: currentFrame.origin.x, y: currentFrame.origin.y, width: labelWidth, height: currentFrame.height)
            self.frame = newFrame
            
            // Setting TitleLabel frame
            titleLabel?.frame = CGRect(x: 0, y: 0, width: labelWidth, height: currentFrame.height)
        }
        
        self.addSubview(titleLabel!)
    }
    
    /**
     * Creates tab containing image or image with text. And adds it as subview to this view.
     *
     * Case FitAllTabs: Creates a tabview of provided width. Doesnot consider padding provided from ViewPagerOptions.
     * ImageView is centered inside tabview if tab type is Image only. Else image margin are used to calculate the position
     * in case of tab type ImageWithText.
     *
     * Case DistributeNormally: Creates a tabView. Width is automatically calculated either from imagesize or text whichever
     * is larger. ImageView is centered inside tabview with provided paddings if tab type is Image only. Considers both padding
     * and image margin incase tab type is ImageWithText.
     */
    
    
    /*--------------------------
     MARK:- Helper Methods
     ---------------------------*/
    
    fileprivate func buildTitleLabel(withOptions options:ViewPagerOptionsB, text:String) {
        
        titleLabel = UILabel()
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = options.tabViewTextDefaultColor
        titleLabel?.numberOfLines = 0
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.font = options.tabViewTextFont
        titleLabel?.text = text
        titleLabel?.font = titleLabel?.font.withSize(15)
        //titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
    }
    
    
    
    /**
     * Updates the frame of the current tab view incase of EvenlyDistributedCondition. Also propagates those
     * changes to titleLabel and imageView based on ViewPagerTabType.
     */
    internal func updateFrame(atIndex index:Int, withWidth width:CGFloat, options:ViewPagerOptionsB) {
        
        // Updating frame of the TabView
        let tabViewCurrentFrame = self.frame
        let tabViewXPosition = CGFloat(index) * width
        let tabViewNewFrame = CGRect(x: tabViewXPosition, y: tabViewCurrentFrame.origin.y, width: width, height: tabViewCurrentFrame.height)
        self.frame = tabViewNewFrame
        
        switch options.tabType {
            
        case .basic:
            
            // Updating frame for titleLabel
            titleLabel?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            
            self.setNeedsUpdateConstraints()
        }
    }
    
    internal func addHighlight(options:ViewPagerOptionsB) {
        
        self.backgroundColor = options.tabViewBackgroundHighlightColor
        self.titleLabel?.textColor = options.tabViewTextHighlightColor
    }
    
    internal func removeHighlight(options:ViewPagerOptionsB) {
        
        self.backgroundColor = options.tabViewBackgroundDefaultColor
        self.titleLabel?.textColor = options.tabViewTextDefaultColor
    }
}

