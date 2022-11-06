//
//  RecipeDetailsViewController.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 05/11/2022.
//

import UIKit

class RecipeDetailsViewController: BaseViewController {

    
    @IBOutlet weak var ingredientsTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ingredientsListTableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeMainLabel: UILabel!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loaderView: UIView!
    
    
    var recipeDetailsPresenter: ViewToPresenterRecipeDetailsProtocol?
    var spinner: UIActivityIndicatorView?
    var recipeDetails: Hits?
    var ingredientsList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailsPresenter?.getRecipesDetails()
        setUpUI()
        registerCells()
    }
   
}

extension RecipeDetailsViewController {
    @IBAction func goToRecipeWebSiteAction(_ sender: Any) {
        recipeDetailsPresenter?.openRecipeWebsiteOnSafari()
    }
    
    @objc func shareButtonPressed() {
        recipeDetailsPresenter?.shareRecipeUrl()
       
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
   
    func setUpData() {
        guard let recipe = recipeDetails?.recipe else {
            return
        }
        self.recipeImageView.loadImageFromUrl(recipe.image)
        self.recipeMainLabel.text = recipe.recipeLabel ?? ""
        if let ingredients = recipe.ingredientLines,
           ingredients.count > 0 {
            ingredientsList = ingredients
            ingredientsListTableView.reloadData()
            setUpIngredientsTableHeight()
        }
    }
    func setUpIngredientsTableHeight() {
        ingredientsTableViewHeightConstraint.constant = CGFloat(ingredientsList.count * 40)
    }
    func registerCells() {
       
        ingredientsListTableView.delegate = self
        ingredientsListTableView.dataSource = self
        
        ingredientsListTableView.registerClassFor(cellClass: UITableViewCell.self)
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

// MARK: UITableViewDataSource
extension RecipeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(cellClass: UITableViewCell.self)
        cell.textLabel!.text = self.ingredientsList[indexPath.row]
        return cell
    }
}

// MARK: UITableViewDelegate
extension RecipeDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
