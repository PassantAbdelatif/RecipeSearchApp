//
//  UIViewExtension.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import Foundation
import UIKit
extension UIView {
    func addPrimaryShadow() {
        
        self.layer.shadowColor = UIColor(red: 0.862, green: 0.871, blue: 0.9, alpha: 0.8).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1.0
    }
}
