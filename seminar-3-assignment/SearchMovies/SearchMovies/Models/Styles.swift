//
//  Styles.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//

import Foundation
import UIKit

struct Styles {
    static let backgroundBlue = UIColor(red: 32/255.0, green: 33/255.0, blue: 44/255.0, alpha: 1.0)
    static let darkGrey = UIColor(red: 135/255.0, green: 134/255.0, blue: 140/255.0, alpha: 1.0)
    static let fontGrey = UIColor(red: 163/255.0, green: 163/255.0, blue: 163/255.0, alpha: 1.0)
}


extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 10
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}

extension UIView {
    public var isShimmering: Bool {
        get {
            return layer.mask?.animation(forKey: shimmerAnimationKey) != nil
        }
        set {
            if newValue {
                startShimmering()
            } else {
                stopShimmering()
            }
        }
    }
    
    private var shimmerAnimationKey: String {
        return "shimmer"
    }
    
    func startShimmering() {
        let white = UIColor.white.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.75).cgColor
        let width = bounds.width
        let height = bounds.height
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, white, alpha]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.6)
        gradient.locations = [0.4, 0.5, 0.6]
        gradient.frame = CGRect(x: -width, y: 0, width: width*3, height: height)
        layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.25
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: shimmerAnimationKey)
    }
    
    func stopShimmering() {
        layer.mask = nil
    }
}
