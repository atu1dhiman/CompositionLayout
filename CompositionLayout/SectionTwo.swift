//
//  SectionTwo.swift
//  CompositionLayout
//
//  Created by Atul Dhiman on 05/09/22.
//

import UIKit

class SectionTwo: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backView.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        
    }

}
