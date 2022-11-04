//
//  HealthLabelCollectionViewCell.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import UIKit

class HealthLabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var mainContentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shadowDecorate()
        self.mainContentView.layer.borderColor = UIColor.gray.cgColor
        self.mainContentView.layer.borderWidth = 1
    }

    func configCell(health: String) {
        self.healthLabel.text = health
    }
}
