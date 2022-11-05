//
//  BaseViewController.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 05/11/2022.
//


import UIKit

enum UpdateListStatus {
    case refresh
    case loadMore
}

class BaseViewController: UIViewController {

    var viewDidLoadCompletion: ((UIViewController) -> Void)?
    var updateListStatus: UpdateListStatus = .refresh
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: nil,
                                                                action: nil)
        self.viewDidLoadCompletion?(self)
    }
  
}

