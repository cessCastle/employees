//
//  Animations.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.

import Foundation
import UIKit


class Animations {
    
    static let shared = Animations()

    func animateButtonPulse(view: UIView, scaleX: CGFloat, y: CGFloat, duration: TimeInterval, withImpact: Bool) {
       
        if withImpact {
            
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        }
        
        UIView.animate(withDuration: duration, animations: {
            
            view.transform = CGAffineTransform(scaleX: scaleX, y: y)
          
        }, completion: { _ in
            UIView.animate(withDuration: duration) {
                view.transform = CGAffineTransform.identity
            }
        })
    }
}
