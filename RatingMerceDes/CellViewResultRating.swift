//
//  CellViewResultRating.swift
//  RatingMerceDes
//
//  Created by MacbookPro on 5/20/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

class CellViewResultRating: UICollectionViewCell {

    var btDismis: (() -> Void)?
    @IBOutlet weak var viewservices: UIView!
    @IBOutlet weak var lbListServices: UILabel!
    @IBOutlet weak var viewSorry: UIView!
    @IBOutlet weak var btNo: UIButton!
    @IBOutlet weak var viewRatingAgain: UIView!
    var btYes: (() -> Void)?
    var btNoAction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btNo.clipsToBounds = true
        self.btNo.layer.borderWidth = 2
        self.btNo.layer.borderColor = #colorLiteral(red: 0, green: 0.6901960784, blue: 0.9529411765, alpha: 1)
    }
    @IBAction func btDismiss(_ sender: UIButton) {
        self.btDismis?()
    }
    @IBAction func btNo(_ sender: UIButton) {
        self.btYes?()
    }
    @IBAction func btYes(_ sender: UIButton) {
        self.btYes?()
    }
    
}
