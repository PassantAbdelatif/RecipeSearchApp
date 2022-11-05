//
//  RecipeTableViewCell.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import UIKit
class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var healthLabelsCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var recipeHealthCollectionView: UICollectionView!
    
    var recipeHealthArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
       // registerCell()

    }
    
    func setUpUI() {
        self.mainContainerView.layer.cornerRadius = 20
        self.mainContainerView.addPrimaryShadow()
    }
    
//    func registerCell() {
//        recipeHealthCollectionView.delegate = self
//        recipeHealthCollectionView.dataSource = self
//        recipeHealthCollectionView.registerNibFor(cellClass: HealthLabelCollectionViewCell.self)
//    }
    
    func configCell(recipe: Recipe) {
        self.recipeImageView.loadImageFromUrl(recipe.image)
        self.recipeLabel.text = recipe.recipeLabel ?? ""
        self.recipeSource.text = recipe.source ?? ""
        if let healthLabels = recipe.healthLabels,
           healthLabels.count > 0 {
            var healthLabelStr = ""
            for healthLabel in healthLabels {
                if healthLabel == healthLabels.last {
                    healthLabelStr += "\(healthLabel)"
                } else {
                    healthLabelStr += "\(healthLabel), "
                }
                
            }
//            self.recipeHealthArr.removeAll()
//            self.recipeHealthArr = healthLabels
//            self.recipeHealthCollectionView.reloadData()
            self.healthLabel.text = healthLabelStr
        } else {
//            self.recipeHealthArr.removeAll()
//            self.recipeHealthCollectionView.reloadData()
            self.healthLabel.text = ""
        }
//        let height = recipeHealthCollectionView.collectionViewLayout.collectionViewContentSize.height
//           healthLabelsCollectionViewHeightConstraint.constant = height
    }
}

//extension RecipeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.recipeHealthArr.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(cellClass: HealthLabelCollectionViewCell.self, for: indexPath)
//        cell.configCell(health: self.recipeHealthArr[indexPath.row])
//        return cell
//    }
//
//
//}
//
//extension RecipeTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: ((recipeHealthArr[indexPath.row].size(withAttributes:
//                                                                    [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11, weight: .medium)]).width) ) + 60,
//                      height: 25)
//    }
//}
