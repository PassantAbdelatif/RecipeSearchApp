//
//  RecipeDetailsViewController.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 05/11/2022.
//

import UIKit

class RecipeDetailsViewController: BaseViewController {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeMainLabel: UILabel!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loaderView: UIView!
    
    
    var recipeDetailsPresenter: ViewToPresenterRecipeDetailsProtocol?
    var spinner: UIActivityIndicatorView?
    var recipeDetails: Hits?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailsPresenter?.getRecipesDetails()
        setUpUI()
    }
    @IBAction func goToRecipeWebSiteAction(_ sender: Any) {
        recipeDetailsPresenter?.openRecipeWebsiteOnSafari()
    }
}

extension RecipeDetailsViewController {
    func setUpUI() {
        self.title = Constants.ScreenTitles.recipeDetailsScreen
        loaderIndicator?.hidesWhenStopped = true
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action,
                                          target: self,
                                          action: #selector(shareButtonPressed))
        
        self.navigationItem.rightBarButtonItem = shareButton
    }
    @objc func shareButtonPressed() {
        recipeDetailsPresenter?.shareRecipeUrl()
       
    }
    func setUpData() {
        guard let recipe = recipeDetails?.recipe else {
            return
        }
        self.recipeImageView.loadImageFromUrl(recipe.image)
        self.recipeMainLabel.text = recipe.recipeLabel ?? ""
    }
}

extension RecipeDetailsViewController: PresenterToViewRecipeDetailsProtocol {
    func startRecipeDetailsViewLoader() {
        loaderView.isHidden = false
        loaderIndicator.startAnimating()
        
    }
    
    func endRecipeDetailsViewLoader() {
        loaderView.isHidden = true
        loaderIndicator.stopAnimating()
    }
    
    func sendRecipeDetailsToView(recipeDetails: Hits) {
        self.recipeDetails = recipeDetails
        setUpData()
    }
    
    func sendErrorToView(error: String) {
        
    }
    
    
}
