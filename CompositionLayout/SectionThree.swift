//
//  SectionThree.swift
//  CompositionLayout
//
//  Created by Atul Dhiman on 05/09/22.
//

import UIKit

class SectionThree: UICollectionViewCell {

    
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.layer.cornerRadius = 8
        self.backView.clipsToBounds = true
        
    }
    func setGradientView(startColor: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [startColor.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.backView.frame.size.width, height: self.backView.frame.size.height)

        self.backView.layer.insertSublayer(gradient, at: 0)
        
    }

}
