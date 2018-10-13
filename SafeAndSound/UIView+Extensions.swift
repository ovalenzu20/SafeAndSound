//
//  UIView+Extensions.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    public func setProperties(bgColor: UIColor?, shadowColor: UIColor?, shadowRadius: CGFloat?, shadowOpacity: Float?, shadowOffset: CGSize?, cornerRadius: CGFloat?, borderColor: UIColor?, borderWidth: CGFloat?) {
        if let bgColor = bgColor {
            self.backgroundColor = bgColor
        }
        
        if let shadowColor = shadowColor {
            self.layer.shadowColor = shadowColor.cgColor
        }
        
        if let shadowRadius = shadowRadius {
            self.layer.shadowRadius = shadowRadius
        }
        
        if let shadowOpacity = shadowOpacity {
            self.layer.shadowOpacity = shadowOpacity
        }
        
        if let shadowOffset = shadowOffset {
            self.layer.shadowOffset = shadowOffset
        }
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
    }
}
