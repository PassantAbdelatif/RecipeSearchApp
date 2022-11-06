//
//  RecipeSearchVC.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import Foundation
import UIKit
import SwiftUI
class RecipeSearchViewController: BaseViewController {
    // MARK: Outlets
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var recipeSearchListTableView: UITableView!
    @IBOutlet weak var recipeHealthLabelCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var recipeSeaarchSuggestedKeyWordsTableView: UITableView!
    
    // MARK: Properties
    var recipeList = [Hits]()
    var healthLabelsList = [String]()
    var suggestedSearchKeys = [String]()
    var recipeSearchPresenter: ViewToPresenterRecipesProtocol?
    var spinner: UIActivityIndicatorView?
    lazy var emptyView : RecipeEmptyView = {
        return RecipeEmptyView()
    }()
    
    // MARK: UIView Lifecycle
    override func viewDidLoad() {
        setUpUI()
        registerCells()
        
        RecipeSearchRouter.createModule(recipeSearchViewController: self)
        
        self.searchTextField.addTarget(self,
                                       action: #selector(textDidChange(sender:)),
                                       for: .editingChanged)
    }
}

// MARK: Actions
extension RecipeSearchViewController {
    @IBAction func searchButtonAction(_ sender: Any) {
        self.recipeSeaarchSuggestedKeyWordsTableView.isHidden = true
        self.recipeHealthLabelCollectionView.isHidden = true
        recipeSearchPresenter?.searchString = self.searchTextField.text ?? ""
        self.recipeSearchPresenter?.saveSearchString()
        self.updateListStatus = .refresh
        self.recipeSearchPresenter?.getRecipesSearchResult(updateListStatus: .refresh)
        
    }
    @objc private func textDidChange(sender: UITextField) {
        // check saved keywords getting from userDefaults
        self.recipeSearchPresenter?.getSavedSearchStrings()
        if self.suggestedSearchKeys.count > 10 {
            //show suggestion view
            if let searchText = self.searchTextField.text,
               !searchText.isEmpty {
                self.searchAutocompleteEntriesWithSubstring(substring: searchText)
            } else {
                recipeSeaarchSuggestedKeyWordsTableView.isHidden = true
            }
        }
    }
    
    
    func searchAutocompleteEntriesWithSubstring(substring: String) {
  
        recipeSeaarchSuggestedKeyWordsTableView.isHidden = false
        recipeSeaarchSuggestedKeyWordsTableView.reloadData()
    }

}

// MARK: SetUpUI & Register Cells
extension RecipeSearchViewController {
    func setUpUI() {
        self.title = Constants.ScreenTitles.recipeSearchScreen
        recipeSeaarchSuggestedKeyWordsTableView.addPrimaryShadow()
        self.searchView.addPrimaryShadow()
        spinner = UIActivityIndicatorView(style: .medium)
        spinner?.hidesWhenStopped = true
        
        self.recipeSearchListTableView.setupLoadingMore {
            self.updateListStatus = .loadMore
            if let hasNext = self.recipeSearchPresenter?.hasNext,
               hasNext {
                self.recipeSearchPresenter?.getRecipesSearchResult(updateListStatus: .loadMore)
            } else {
                DispatchQueue.main.async() {
                    self.recipeSearchListTableView.endLoadingMoreAndRefreshing()
                }
            }
            
        }
        self.recipeSearchListTableView.setupRefresh {
            self.updateListStatus = .refresh
            self.recipeSearchPresenter?.getRecipesSearchResult(updateListStatus: .refresh)
        }
    }
    
    func registerCells() {
        recipeSearchListTableView.delegate = self
        recipeSearchListTableView.dataSource = self
        //RecipeTableViewCell
        recipeSearchListTableView.registerNibFor(cellClass: RecipeTableViewCell.self)
        // Set automatic dimensions for row height
        recipeSearchListTableView.rowHeight = UITableView.automaticDimension
        recipeSearchListTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.searchTextField.delegate = self

        recipeHealthLabelCollectionView.delegate = self
        recipeHealthLabelCollectionView.dataSource = self
        recipeHealthLabelCollectionView.registerNibFor(cellClass: HealthLabelCollectionViewCell.self)
        
        recipeSeaarchSuggestedKeyWordsTableView.delegate = self
        recipeSeaarchSuggestedKeyWordsTableView.dataSource = self
        recipeSeaarchSuggestedKeyWordsTableView.isScrollEnabled = true
        recipeSeaarchSuggestedKeyWordsTableView.isHidden = true
        
        recipeSeaarchSuggestedKeyWordsTableView.registerClassFor(cellClass: UITableViewCell.self)
    }
}
// MARK: GetData
extension RecipeSearchViewController: PresenterToViewRecipesProtocol {
    func sendSavedSearchStringsToView(savedSearchStrings: [String]) {
        //show suggestion view
        self.suggestedSearchKeys = savedSearchStrings
    }
    
    func sendHealthCategoriesDataToView(healthLabels: [String]) {
        
        if let selectedHealthFilter = self.recipeSearchPresenter?.selectedHealthFilter {

            if let selectedHealthFilterIndex = self.healthLabelsList.firstIndex(where: {$0 == selectedHealthFilter}) {
                recipeHealthLabelCollectionView.selectItem(at: IndexPath(item: selectedHealthFilterIndex, section: 0),
                                          animated: true,
                                          scrollPosition: .top )
            }
        } else {
            if recipeList.count > 0 {
                self.recipeHealthLabelCollectionView.isHidden = false
                self.healthLabelsList.removeAll()
                self.healthLabelsList.append(contentsOf: healthLabels)
                self.recipeHealthLabelCollectionView.reloadData()
                // select ALL
                recipeHealthLabelCollectionView.selectItem(at: IndexPath(item: 0, section: 0),
                                          animated: true,
                                          scrollPosition: .top )
            } else {
                self.recipeHealthLabelCollectionView.isHidden = true
            }
           
        }
        
    }
    
    func startViewLoader() {
        spinner?.startAnimating()
        recipeSearchListTableView.backgroundView = spinner
    }
    
    func endViewLoader() {
        spinner?.stopAnimating()
        spinner?.hidesWhenStopped = true
        recipeSearchListTableView.backgroundView = nil
       
    }
    
    func sendErrorToView(error: String) {
        spinner?.stopAnimating()
        spinner?.hidesWhenStopped = true
        recipeSearchListTableView.backgroundView = nil
        recipeSearchListTableView.endLoadingMoreAndRefreshing()
        let alert = UIAlertController(title: "Error",
                                      message: error,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    func sendDataToView(recipeList: [Hits]) {
        
        switch self.updateListStatus {
        case .refresh:
            
            self.recipeList.removeAll()
            self.recipeList = recipeList
            recipeSearchPresenter?.getRecipeHealthCategories()
            
        case .loadMore:
            self.recipeList.append(contentsOf: recipeList)
        }
        
        recipeSearchListTableView.reloadData(isEmpty:  self.recipeList.isEmpty,
                                             noDataView: self.emptyView)
        recipeSearchListTableView.endLoadingMoreAndRefreshing()
    }
}

// MARK: UITableViewDataSource
extension RecipeSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.recipeSearchListTableView {
            return self.recipeList.count
        } else {
            return self.suggestedSearchKeys.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.recipeSearchListTableView {
        let cell = tableView.dequeueReusableCell(cellClass: RecipeTableViewCell.self)
        if recipeList.count > 0 {
            if let recipe = self.recipeList[indexPath.row].recipe {
                cell.configCell(recipe: recipe)
            }
        }

        return cell
        } else {
            let cell = tableView.dequeueReusableCell(cellClass: UITableViewCell.self)
            
            cell.textLabel!.text = self.suggestedSearchKeys[indexPath.row]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.recipeSearchListTableView {
            RecipeSearchRouter.pushToRecipeDetialsScreen(recipe: self.recipeList[indexPath.row],
                                                         navigationConroller: self.navigationController!)
        } else {
            searchTextField.text = self.suggestedSearchKeys[indexPath.row]
            self.recipeSeaarchSuggestedKeyWordsTableView.isHidden = true
        }
    }
    
}
// MARK: UITableViewDelegate
extension RecipeSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension RecipeSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.healthLabelsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: HealthLabelCollectionViewCell.self, for: indexPath)
        cell.configCell(health: self.healthLabelsList[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFilter = self.healthLabelsList[indexPath.row]
        self.updateListStatus = .refresh
        if indexPath.row == 0 {
            self.recipeSearchPresenter?.selectedHealthFilter = nil
        } else {
            self.recipeSearchPresenter?.selectedHealthFilter = selectedFilter
        }
        
        self.recipeSearchPresenter?.getRecipesSearchResult(updateListStatus: .refresh)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension RecipeSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((healthLabelsList[indexPath.row].size(withAttributes:
                                                                    [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11,
                                                                                                                     weight: .medium)]).width) ) + 60,
                      height: 25)
    }
}


// MARK: UITextFieldDelegate
extension RecipeSearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*",
                                                options: [])
            if regex.firstMatch(in: string,
                                options: [],
                                range: NSMakeRange(0,
                                                   string.count)) != nil {
                return false
            }
        }
        catch {
            
        }
        
        guard range.location == 0 else {
            return true
        }

        let newString = (textField.text! as NSString).replacingCharacters(in: range,
                                                                          with: string) as NSString
        
        let spacesCondition = newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
        return spacesCondition
    }
}
