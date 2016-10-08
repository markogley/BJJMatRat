//
//  UIViewFade.swift
//  BJJ Mat Rat
//
//  Created by Mark Ogley on 2016-09-29.
//  Copyright © 2016 Mark Ogley. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    
    func fadeOut() {
        
        UIView.animate(withDuration: 1, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { 
            
            self.alpha = 0.0 
            
            }, completion: nil )
        
    }
    
    
    func roundedCorners() {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 20, height: 20))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
    }
    
    func blurredBackground(style: String) -> UIVisualEffectView {
        
        let blurType: UIBlurEffectStyle
        
        switch style {
        
        case "Light":
            blurType = UIBlurEffectStyle.light
        case "Dark":
            blurType = UIBlurEffectStyle.dark
        case "ExtraLight":
            blurType = UIBlurEffectStyle.extraLight
        case "Prominent":
            if #available(iOS 10.0, *) {
                blurType = UIBlurEffectStyle.prominent
            } else {
                // Fallback on earlier versions
                blurType = UIBlurEffectStyle.light
            }
        case "Regular":
            if #available(iOS 10.0, *) {
                blurType = UIBlurEffectStyle.regular
            } else {
                // Fallback on earlier versions
                blurType = UIBlurEffectStyle.light
            }
        default:
            blurType = UIBlurEffectStyle.light
            
        }
        
        
        let blurEffect = UIBlurEffect(style: blurType)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
    
        return blurView
    
    }
    
    
    
    
    
    
}
