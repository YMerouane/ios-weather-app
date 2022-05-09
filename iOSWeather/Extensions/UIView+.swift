//
//  UIView+Extension.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

enum SeparatorPosition {
    case bottom
    case top
}

extension UIView {
    /// Adds multiple UI Views as subviews
    ///
    /// - Parameters:
    ///     - subview:  UI Views to add
    func addMultipleSubviews(_ subviews: UIView...) {
        subviews.forEach {
            self.addSubview($0)
        }
    }
    
    func addGradientBackground() {
        let random = UIColor.random().cgColor
        let random2 = UIColor.random().cgColor
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [random, random2]
        layer.addSublayer(gradient)
    }
    
    func addSeparator(to position: SeparatorPosition, color: UIColor = .weatherTransparent,
                      of height: CGFloat = 0.75, aboveSubview: UIView) {
        guard self.contains(aboveSubview)  else {
            print("aboveSubview \(aboveSubview.description) is not added into view heiarchy. Try to add it first")
            return
        }
        let separator = UIView()
        separator.backgroundColor = color
        separator.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(separator, aboveSubview: aboveSubview)
        separator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
            switch position {
            case .top:
                make.top.equalToSuperview()
            case .bottom:
                make.bottom.equalToSuperview()
            }
            
        }
        
    }
    func blur(style: UIBlurEffect.Style ) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    
}


