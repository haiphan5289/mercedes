//
//  ViewRatingSad.swift
//  RatingMerceDes
//
//  Created by MacbookPro on 5/20/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

protocol ViewRatingSadListner {
    func dismiss()
}

class ViewRatingSad: UIViewController {

    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var btFactor: UIButton!
    @IBOutlet weak var btsevicessale: UIButton!
    @IBOutlet weak var btDevies: UIButton!
    @IBOutlet weak var btCare: UIButton!
    @IBOutlet weak var btWater: UIButton!
    @IBOutlet weak var vFactor: UIView!
    @IBOutlet weak var imgFactor: UIImageView!
    @IBOutlet weak var vServiceSale: UIView!
    @IBOutlet weak var imgServiceSale: UIImageView!
    @IBOutlet weak var vDevice: UIView!
    @IBOutlet weak var imgDevice: UIImageView!
    @IBOutlet weak var vCare: UIView!
    @IBOutlet weak var imgCare: UIImageView!
    @IBOutlet weak var vWater: UIView!
    @IBOutlet weak var imgWater: UIImageView!
    var listService: [String] = []
    var listner: ViewRatingSadListner?
    override func viewDidLoad() {
        super.viewDidLoad()
        btNext.clipsToBounds = true
        btNext.layer.cornerRadius = 5
        
        vFactor.clipsToBounds = true
        vFactor.layer.cornerRadius = 5
        
        vServiceSale.clipsToBounds = true
        vServiceSale.layer.cornerRadius = 5
        
        vDevice.clipsToBounds = true
        vDevice.layer.cornerRadius = 5
        
        vCare.clipsToBounds = true
        vCare.layer.cornerRadius = 5
        
        vWater.clipsToBounds = true
        vWater.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }
    @IBAction func btBack(_ sender: UIButton) {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewRatingAgain") as! ViewRatingAgain
            vc.modalPresentationStyle = .overFullScreen
            vc.listener = self
//            vc.listService = self.listService
            self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btContinue(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewResultRatingSad") as! ViewResultRatingSad
        vc.modalPresentationStyle = .fullScreen
        vc.listService = self.listService
        vc.listner = self
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func btServiceSale(_ sender: Any) {
        if btsevicessale.isSelected {
            self.btsevicessale.isSelected = false
//            ic_uncheck
            self.btsevicessale.setImage(UIImage(named: "ic_uncheck"), for: .normal)
            self.addList(isSelect: false, text: "Dịch vụ bán hàng")
            self.imgServiceSale.image = UIImage()
        } else {
            self.btsevicessale.isSelected = true
            self.btsevicessale.setImage(UIImage(named: "check"), for: .normal)
            self.addList(isSelect: true, text: "Dịch vụ bán hàng")
            self.imgServiceSale.image = UIImage(named: "check")
        }
    
    }
    @IBAction func btFactor(_ sender: UIButton) {
        if btFactor.isSelected {
            self.btFactor.isSelected = false
            self.addList(isSelect: false, text: "Xưởng dịch vụ")
            self.btFactor.setImage(UIImage(named: "ic_uncheck"), for: .normal)
            self.imgFactor.image = UIImage()
        } else {
            self.btFactor.isSelected = true
            self.addList(isSelect: true, text: "Xưởng dịch vụ")
            self.btFactor.setImage(UIImage(named: "check"), for: .normal)
            self.imgFactor.image = UIImage(named: "check")
        }
    }
    
    @IBAction func btDevices(_ sender: Any) {
        if btDevies.isSelected {
            self.btDevies.isSelected = false
            self.addList(isSelect: false, text: "Cở sở vật chất")
            self.btDevies.setImage(UIImage(named: "ic_uncheck"), for: .normal)
            self.imgDevice.image = UIImage()
        } else {
            self.btDevies.isSelected = true
            self.addList(isSelect: true, text: "Cở sở vật chất")
            self.btDevies.setImage(UIImage(named: "check"), for: .normal)
            self.imgDevice.image = UIImage(named: "check")
        }
    }
    
    @IBAction func btCare(_ sender: Any) {
        if btCare.isSelected {
            self.btCare.isSelected = false
            self.addList(isSelect: false, text: "Bộ phận tiếp đón")
            self.btCare.setImage(UIImage(named: "ic_uncheck"), for: .normal)
            self.imgCare.image = UIImage()
        } else {
            self.btCare.isSelected = true
            self.addList(isSelect: true, text: "Bộ phận đón tiếp")
            self.btCare.setImage(UIImage(named: "check"), for: .normal)
            self.imgCare.image = UIImage(named: "check")
        }
    }
    
    
    @IBAction func btWater(_ sender: Any) {
        if btWater.isSelected {
            self.btWater.isSelected = false
            self.addList(isSelect: false, text: "Dịch vụ trà nước")
            self.btWater.setImage(UIImage(named: "ic_uncheck"), for: .normal)
            self.imgWater.image = UIImage()
        } else {
            self.btWater.isSelected = true
            self.addList(isSelect: true, text: "Dịch vụ trà nước")
            self.btWater.setImage(UIImage(named: "check"), for: .normal)
            self.imgWater.image = UIImage(named: "check")
        }
    }
    private func addList(isSelect: Bool, text: String) {
        if isSelect {
            self.listService.append(text)
        } else {
            for (index, item) in self.listService.enumerated() {
                if item == text {
                    self.listService.remove(at: index)
                }
            }
        }
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    
}
extension ViewRatingSad: ViewRatingAgainAction {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.listner?.dismiss()
        }
    }
    
    
}
extension ViewRatingSad: ViewResultRatingSadListner {
    func dismissViewResultRatingSadListner() {
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
             self.dismiss(animated: true, completion: nil)
            self.listner?.dismiss()
        }
    }
}
