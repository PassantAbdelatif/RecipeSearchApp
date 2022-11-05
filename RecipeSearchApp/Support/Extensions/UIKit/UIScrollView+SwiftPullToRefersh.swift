//
//  UIScrollView+SwiftPullToRefersh.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 05/11/2022.
//

import SwiftPullToRefresh

extension UIScrollView {
    
    func refresh() {
        self.spr_beginRefreshing()
    }
    
    func setupRefresh(_ completion : @escaping () -> Void) {
        self.spr_setIndicatorHeader(action: completion)
    }
    
    func endLoadingMoreAndRefreshing() {
        self.spr_endRefreshing()
    }
    
    func setupLoadingMore(_ completion : @escaping () -> Void) {
        self.spr_setIndicatorAutoFooter(action: completion)
    }
}
