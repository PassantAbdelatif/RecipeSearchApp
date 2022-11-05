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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var autocompleteTableView: UITableView!
    
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
        
        RecipeSearchRouter.createModule(ref: self)
        
        self.searchTextField.addTarget(self,
                                       action: #selector(textDidChange(sender:)),
                                       for: .editingChanged)
    }
}

// MARK: Actions
extension RecipeSearchViewController {
    @IBAction func searchButtonAction(_ sender: Any) {
        self.autocompleteTableView.isHidden = true
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
                autocompleteTableView.isHidden = true
            }
            
        }
    }
    
    
    func searchAutocompleteEntriesWithSubstring(substring: String) {
  
        autocompleteTableView.isHidden = false
        autocompleteTableView.reloadData()
    }

}

// MARK: SetUpUI & Register Cells
extension RecipeSearchViewController {
    func setUpUI() {
        
        autocompleteTableView.addPrimaryShadow()
        self.searchView.addPrimaryShadow()
        spinner = UIActivityIndicatorView(style: .medium)
        spinner?.hidesWhenStopped = true
        
        self.tableView.setupLoadingMore {
            self.updateListStatus = .loadMore
            if let hasNext = self.recipeSearchPresenter?.hasNext,
               hasNext {
                self.recipeSearchPresenter?.getRecipesSearchResult(updateListStatus: .loadMore)
            } else {
                DispatchQueue.main.async() {
                    self.tableView.endLoadingMoreAndRefreshing()
                }
            }
            
        }
        
        self.tableView.setupRefresh {
            self.updateListStatus = .refresh
            self.recipeSearchPresenter?.getRecipesSearchResult(updateListStatus: .refresh)
        }
        
        
    }
    
    func registerCells() {
        tableView.delegate = self
        tableView.dataSource = self
        //RecipeTableViewCell
        tableView.registerNibFor(cellClass: RecipeTableViewCell.self)
        // Set automatic dimensions for row height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.searchTextField.delegate = self

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNibFor(cellClass: HealthLabelCollectionViewCell.self)
        
        autocompleteTableView.delegate = self
        autocompleteTableView.dataSource = self
        autocompleteTableView.isScrollEnabled = true
        autocompleteTableView.isHidden = true
        
        autocompleteTableView.registerClassFor(cellClass: UITableViewCell.self)
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
                collectionView.selectItem(at: IndexPath(item: selectedHealthFilterIndex, section: 0),
                                          animated: true,
                                          scrollPosition: .top )
            }
        } else {
            self.healthLabelsList.removeAll()
            self.healthLabelsList.append(contentsOf: healthLabels)
            self.collectionView.reloadData()
            // select ALL
            collectionView.selectItem(at: IndexPath(item: 0, section: 0),
                                      animated: true,
                                      scrollPosition: .top )
        }
        
    }
    
    func startViewLoader() {
        spinner?.startAnimating()
        tableView.backgroundView = spinner
    }
    
    func endViewLoader() {
        spinner?.startAnimating()
        tableView.backgroundView = nil
    }
    
    func sendErrorToView(error: String) {
        
    }
    
    func sendDataToView(recipeList: [Hits]) {
    
        switch self.updateListStatus {
        case .refresh:
           
            self.recipeList.removeAll()
            self.recipeList = recipeList
            if self.recipeList.count > 0 {
                self.recipeSearchPresenter?.getRecipeHealthCategories()
            }
        case .loadMore:
            self.recipeList.append(contentsOf: recipeList)
        }

        DispatchQueue.main.async() {
            self.tableView.reloadData(isEmpty:  self.recipeList.isEmpty,
                                      noDataView: self.emptyView)
            self.tableView.endLoadingMoreAndRefreshing()
        }
       
    }

}

// MARK: UITableViewDataSource
extension RecipeSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return self.recipeList.count
        } else {
            return self.suggestedSearchKeys.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
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
        if tableView == self.tableView {
            //go to details
        } else {
            searchTextField.text = self.suggestedSearchKeys[indexPath.row]
            self.autocompleteTableView.isHidden = true
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
        self.recipeSearchPresenter?.selectedHealthFilter = selectedFilter
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
