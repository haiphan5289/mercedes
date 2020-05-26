//
//  ViewController.swift
//  RatingMerceDes
//
//  Created by MacbookPro on 5/20/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btStart.clipsToBounds = true
        btStart.layer.cornerRadius = 5
    }

    @IBAction func moveViewSelect(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewSelect") as! ViewSelect
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

