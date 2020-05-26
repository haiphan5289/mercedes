//
//  ViewSelect.swift
//  RatingMerceDes
//
//  Created by MacbookPro on 5/20/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

protocol ViewHomeListner {
    func dismiss()
}

class ViewSelect: UIViewController {

    @IBOutlet weak var viewSad: UIView!
    @IBOutlet weak var viewHappy: UIView!
    var listner: ViewHomeListner?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSad.clipsToBounds = true
        viewSad.layer.cornerRadius = 19
        viewHappy.clipsToBounds = true
        viewHappy.layer.cornerRadius = 19
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    @IBAction func btBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moveRatingSad(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewRatingSad") as! ViewRatingSad
        vc.modalPresentationStyle = .fullScreen
        vc.listner = self
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func moveHappy(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewHappy") as! ViewHappy
               vc.modalPresentationStyle = .fullScreen
        vc.listner = self
               self.present(vc, animated: true, completion: nil)
    }
}
extension ViewSelect: ViewRatingSadListner {
    func dismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
extension ViewSelect: ViewHappyListner {
    func dismissViewHappyListner() {
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                   self.dismiss(animated: true, completion: nil)
               }
    }
    
    
}
