//
//  SearchEmptyView.swift
//  BeutiCustomer
//
//  Created by Mohamad Basuony on 23/08/2022.
//  Copyright © 2022 Michelle. All rights reserved.
//

import UIKit

class SearchEmptyView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var searchWordLbl: UILabel!
    
    var searchWord = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("SearchEmptyView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        self.view.frame = self.bounds
        searchWordLbl.text = "\"\(searchWord)\""
    }

}
