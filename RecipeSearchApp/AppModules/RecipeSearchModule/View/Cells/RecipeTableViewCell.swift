//
//  RecipeTableViewCell.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import UIKit
class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var recipeHealthCollectionView: UICollectionView!
    
    var recipeHealthArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //register HealthLabelCollectionViewCell
        recipeHealthCollectionView.delegate = self
        recipeHealthCollectionView.dataSource = self
        recipeHealthCollectionView.register(UINib(nibName: "HealthLabelCollectionViewCell",
                                                  bundle: .main), forCellWithReuseIdentifier: "HealthLabelCollectionViewCell")

    }

    func configCell(recipe: Recipe) {
        self.recipeImageView.loadImageFromUrl(recipe.image)
        self.recipeLabel.text = recipe.recipeLabel ?? ""
        self.recipeSource.text = recipe.source ?? ""
        if let healthLabels = recipe.healthLabels,
           healthLabels.count > 0 {
            self.recipeHealthArr.removeAll()
            self.recipeHealthArr = healthLabels
            self.recipeHealthCollectionView.reloadData()
        } else {
            self.recipeHealthArr.removeAll()
            self.recipeHealthCollectionView.reloadData()
        }
    }
}

extension RecipeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recipeHealthArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HealthLabelCollectionViewCell", for: indexPath) as? HealthLabelCollectionViewCell
        cell?.configCell(health: self.recipeHealthArr[indexPath.row])
        return cell!
    }
    
    
}

extension RecipeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((recipeHealthArr[indexPath.row].size(withAttributes:
                                                                    [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width) ) + 30,
                      height: 40)
    }
}
