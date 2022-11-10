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
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                UIView.animate(withDuration: 0.3) { // for animation effect
                    self.mainContentView.backgroundColor = UIColor.green
                    self.healthLabel.textColor = UIColor.white
                }
            }
            else {
                UIView.animate(withDuration: 0.3) { // for animation effect
                    self.mainContentView.backgroundColor = UIColor.systemGray3
                    self.healthLabel.textColor = UIColor.secondaryLabel
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(health: String) {
        self.healthLabel.text = health
    }
}
