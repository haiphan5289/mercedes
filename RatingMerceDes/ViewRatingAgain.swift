//
//  ViewRatingAgain.swift
//  RatingMerceDes
//
//  Created by MacbookPro on 5/26/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

protocol ViewRatingAgainAction {
    func dismiss()
}
class ViewRatingAgain: UIViewController {

    @IBOutlet weak var btYes: UIButton!
    @IBOutlet weak var btNo: UIButton!
    @IBOutlet weak var vContent: UIView!
    var listener: ViewRatingAgainAction?
    override func viewDidLoad() {
        super.viewDidLoad()
        vContent.clipsToBounds = true
        vContent.layer.cornerRadius = 10
        
        btNo.clipsToBounds = true
        btNo.layer.cornerRadius = 5
        
        btYes.clipsToBounds = true
        btYes.layer.cornerRadius = 5
        
        self.btNo.clipsToBounds = true
               self.btNo.layer.borderWidth = 2
               self.btNo.layer.borderColor = #colorLiteral(red: 0, green: 0.6901960784, blue: 0.9529411765, alpha: 1)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    @IBAction func btNo(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btYesAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.listener?.dismiss()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
