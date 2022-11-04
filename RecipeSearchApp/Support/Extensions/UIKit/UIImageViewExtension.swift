//
//  UIImageViewExtension.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func loadImageFromUrl(_ urlStr: String?,
                          placeholderImage: UIImage? = nil,
                          completion: (() -> Void)? = nil) {
        if let url = URL(string: urlStr?.toURLString() ?? "") {
            self.kf.setImage(with: url,
                             placeholder: placeholderImage) { _ in
                                completion?()
            }
        }
    }
}
