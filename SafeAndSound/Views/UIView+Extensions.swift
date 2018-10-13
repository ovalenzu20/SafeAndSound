//
//  UIView+Extensions.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import Foundation
import UIKit


struct Padding {
    var x      : CGFloat
    var y      : CGFloat
    var top    : CGFloat
    var left   : CGFloat
    var right  : CGFloat
    var bottom : CGFloat
    
    init(x: CGFloat = 0, y: CGFloat = 0, top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
        self.x      = x
        self.y      = y
        self.top    = top
        self.left   = left
        self.right  = right
        self.bottom = bottom
    }
}


enum Proximity {
    case greaterThanOrEqualTo
    case lessThanOrEqualTo
}


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
    
    
    func anchor(centerX  : NSLayoutXAxisAnchor? = nil, centerXProximity  : Proximity? = nil,
                centerY  : NSLayoutYAxisAnchor? = nil, centerYProximity  : Proximity? = nil,
                top      : NSLayoutYAxisAnchor?,       topProximity      : Proximity? = nil,
                leading  : NSLayoutXAxisAnchor?,       leadingProximity  : Proximity? = nil,
                bottom   : NSLayoutYAxisAnchor?,       bottomProximity   : Proximity? = nil,
                trailing : NSLayoutXAxisAnchor?,       trailingProximity : Proximity? = nil,
                padding  : Padding = Padding(),
                width    : CGFloat = 0,
                height   : CGFloat = 0)
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            if let centerXProximity = centerXProximity {
                switch centerXProximity {
                case .greaterThanOrEqualTo:
                    self.centerXAnchor.constraint(greaterThanOrEqualTo: centerX, constant: padding.x).isActive = true
                case .lessThanOrEqualTo:
                    self.centerXAnchor.constraint(lessThanOrEqualTo:    centerX, constant: padding.x).isActive = true
                }
            }
            else {
                self.centerXAnchor.constraint(equalTo: centerX).isActive = true
            }
        }
        
        if let centerY = centerY {
            if let centerYProximity = centerYProximity {
                switch centerYProximity {
                case .greaterThanOrEqualTo:
                    self.centerYAnchor.constraint(greaterThanOrEqualTo: centerY, constant: padding.y).isActive = true
                case .lessThanOrEqualTo:
                    self.centerYAnchor.constraint(lessThanOrEqualTo:    centerY, constant: padding.y).isActive = true
                }
            }
            else {
                self.centerYAnchor.constraint(equalTo: centerY).isActive = true
            }
        }
        
        if let top = top {
            if let topProximity = topProximity {
                switch topProximity {
                case .greaterThanOrEqualTo :
                    self.topAnchor.constraint(greaterThanOrEqualTo: top, constant: padding.top).isActive = true
                case .lessThanOrEqualTo    :
                    self.topAnchor.constraint(lessThanOrEqualTo:    top, constant: padding.top).isActive = true
                }
            }
            else {
                self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            }
        }
        
        if let leading = leading {
            if let leadingProximity = leadingProximity {
                switch leadingProximity {
                case .greaterThanOrEqualTo :
                    self.leadingAnchor.constraint(greaterThanOrEqualTo: leading, constant: padding.left).isActive = true
                case .lessThanOrEqualTo    :
                    self.leadingAnchor.constraint(lessThanOrEqualTo:    leading, constant: padding.left).isActive = true
                }
            }
            else {
                self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
            }
        }
        
        if let bottom = bottom {
            if let bottomProximity = bottomProximity {
                switch bottomProximity {
                case .greaterThanOrEqualTo :
                    self.bottomAnchor.constraint(greaterThanOrEqualTo: bottom, constant: -padding.bottom).isActive = true
                case .lessThanOrEqualTo    :
                    self.bottomAnchor.constraint(lessThanOrEqualTo:    bottom, constant: -padding.bottom).isActive = true
                }
            }
            else {
                self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            }
        }
        
        if let trailing = trailing {
            if let trailingProximity = trailingProximity {
                switch trailingProximity {
                case .greaterThanOrEqualTo :
                    self.trailingAnchor.constraint(greaterThanOrEqualTo: trailing, constant: -padding.right).isActive = true
                case .lessThanOrEqualTo    :
                    self.trailingAnchor.constraint(lessThanOrEqualTo:    trailing, constant: -padding.right).isActive = true
                }
            }
            else {
                self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
            }
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
