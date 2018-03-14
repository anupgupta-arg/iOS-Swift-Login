//
//  UIView+Border.swift
//  Kitply
//
//  Created by Anup Gupta Developer on 06/02/18.
//  Copyright © 2018 Acviss. All rights reserved.
//

import UIKit
import Swift

extension UIView {
    
    
    func showBorder1() -> UIView {
        
        let myview = self
        
            let blueColor = UIColor.init(red: 5.0/255.0, green: 142.0/255.0, blue: 223/255.0, alpha: 1)
            myview.layer.cornerRadius = 5.0
//            let lightGrayColor = UIColor.lightGray
            myview.layer.borderColor = blueColor.cgColor
            myview.layer.borderWidth = 2.0
            myview.layer.shadowColor = UIColor (red: 225.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 1.0).cgColor
            myview.layer.shadowOpacity = 1.0
            myview.layer.shadowRadius = 5.0
        
            let cgsize = CGSize(width: 5.0, height: 5.0)
            myview.layer.shadowOffset = cgsize
        
        return myview
    }
    
    // objective C code Below
    
    
    
    
    //        UIView* shadowView = [cell viewWithTag:99];
    //        shadowView.backgroundColor=[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:0.5];
    //        [shadowView.layer setCornerRadius:5.0f];
    //        [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    //        [shadowView.layer setBorderWidth:0.2f];
    //        [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
    //        [shadowView.layer setShadowOpacity:1.0];
    //        [shadowView.layer setShadowRadius:5.0];
    //        [shadowView.layer setShadowOffset:CGSizeMake(5.0f, 5.0f)];
    
    func showShadow1() -> UIView {
        let myview = self
        
        
        myview.layer.cornerRadius = 5.0
        let lightGrayColor = UIColor.lightGray
        myview.layer.borderColor = lightGrayColor.cgColor
        myview.layer.borderWidth = 2.0
        myview.layer.shadowColor = UIColor (red: 225.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 1.0).cgColor
        myview.layer.shadowOpacity = 1.0
        myview.layer.shadowRadius = 5.0
        
        let cgsize = CGSize(width: 5.0, height: 5.0)
        myview.layer.shadowOffset = cgsize
        
        return myview
    }
    
    func showShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 2.0 , scale: Bool = true) {
        
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1

    }
    
    func showBorder(color: UIColor = .white, radius: CGFloat = 5.0, width : CGFloat = 1.0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = radius
    }
    
}
