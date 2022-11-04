//
//  RecipeSearchVC.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import Foundation
import UIKit
class RecipeSearchVC: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var recipeList = [Hits]()
    var recipeSearchPresenter: ViewToPresenterRecipesProtocol?
    var selectedHealthFilter: String?
    var nextUrl: String?
    var hasNext: Bool = false
    var searchString = ""
    var activityIndicator : LoadMoreActivityIndicator?
    
    override func viewDidLoad() {
        setUpUI()
        registerCells()
        
        RecipeSearchRouter.createModule(ref: self)
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        
        searchString = self.searchTextField.text ?? ""
        self.recipeList.removeAll()
        self.recipeSearchPresenter?.getRecipesSearchResult(searchString: self.searchTextField.text ?? "",
                                                           healthFilter: selectedHealthFilter,
                                                           nextUrl: nextUrl)
        
    }
    
}

extension RecipeSearchVC {
    func setUpUI() {
        self.searchView.addPrimaryShadow()
        activityIndicator = LoadMoreActivityIndicator(scrollView: self.tableView,
                                                      spacingFromLastCell: 10,
                                                      spacingFromLastCellWhenLoadMoreActionStart: 60)

    }
    func registerCells() {
        tableView.delegate = self
        tableView.dataSource = self
        //RecipeTableViewCell
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")

    }
}

extension RecipeSearchVC: PresenterToViewRecipesProtocol {
    func startViewLoader() {
        
    }
    
    func endViewLoader() {
        
    }
    
    func sendErrorToView(error: String) {
        
    }
    
    func sendDataToView(recipeList: [Hits],
                        hasNextPage: Bool,
                        nextUrl: String?) {
        self.nextUrl = nextUrl
        self.hasNext = hasNextPage
        self.recipeList.append(contentsOf: recipeList)
        self.tableView.reloadData()
    }

}

extension RecipeSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipeList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell") as? RecipeTableViewCell
        if let recipe = self.recipeList[indexPath.row].recipe {
            cell?.configCell(recipe: recipe)
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.hasNext {
            activityIndicator?.start {
                DispatchQueue.global(qos: .utility).async {
                    sleep(1)
                    DispatchQueue.main.async { [weak self] in
                        self?.recipeSearchPresenter?.getRecipesSearchResult(searchString: self?.searchString ?? "",
                                                                            healthFilter: self?.selectedHealthFilter,
                                                                            nextUrl: self?.nextUrl)
                        DispatchQueue.main.async { [weak self] in
                            self?.activityIndicator?.stop()
                        }
                    }
                }
            }
        }
    }
}
