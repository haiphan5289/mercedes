//
//  ViewSelect.swift
//  RatingMerceDes
//
//  Created by MacbookPro on 5/20/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

class ViewSelect: UIViewController {

    @IBOutlet weak var viewSad: UIView!
    @IBOutlet weak var viewHappy: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSad.clipsToBounds = true
        viewSad.layer.cornerRadius = 19
        viewHappy.clipsToBounds = true
        viewHappy.layer.cornerRadius = 19
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moveRatingSad(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewRatingSad") as! ViewRatingSad
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func moveHappy(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewHappy") as! ViewHappy
               vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true, completion: nil)
    }
}
