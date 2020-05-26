//
//  ViewResultRatingSad.swift
//  RatingMerceDes
//
//  Created by MacbookPro on 5/20/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

protocol ViewResultRatingSadListner {
    func dismissViewResultRatingSadListner()
}

class ViewResultRatingSad: UIViewController {
    
    var collect: UICollectionView = {
          //khơi tạo layout thì collective mới hoạt động
          let layout = UICollectionViewFlowLayout()
          //sang chế đô horizontal
          layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
          //khoảng cách giữ cách cell = 0
          layout.minimumLineSpacing = 0
          let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
          v.backgroundColor = UIColor.white
          //hiển thị kiểu page
          v.isPagingEnabled = true
          
          return v
      }()
    var height: NSLayoutConstraint!
    var width: NSLayoutConstraint!
    var widthEqualToSuperView: NSLayoutConstraint!
    var halfWidthOfSuperview: NSLayoutConstraint!
    var veticalbtregister: [NSLayoutConstraint]?
    var hozrizontalbtregister: [NSLayoutConstraint]?
    var listService: [String] = []
    var listner: ViewResultRatingSadListner?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collect)
        
        collect.delegate = self
        collect.dataSource = self
        
        let cellNib = UINib(nibName: "CellViewResultRating", bundle: nil)
        self.collect.register(cellNib, forCellWithReuseIdentifier: "cell")
        
        
        collect.translatesAutoresizingMaskIntoConstraints = false
        veticalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect ?? "hihi"])
        hozrizontalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect ?? "hihi"])
        view.addConstraints(veticalbtregister!)
        view.addConstraints(hozrizontalbtregister!)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            view.removeConstraints(veticalbtregister!)
            view.removeConstraints(hozrizontalbtregister!)
            veticalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect ?? "hihi"])
            hozrizontalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect ?? "hihi"])
            view.addConstraints(veticalbtregister!)
            view.addConstraints(hozrizontalbtregister!)
            collect.reloadData()
        } else {
            view.removeConstraints(veticalbtregister!)
            view.removeConstraints(hozrizontalbtregister!)
            veticalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect ?? "hihi"])
            hozrizontalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect ?? "hihi"])
            view.addConstraints(veticalbtregister!)
            view.addConstraints(hozrizontalbtregister!)
            collect.reloadData()
        }
    }


}
extension ViewResultRatingSad: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellViewResultRating
        if indexPath.row == 1 {
            let text = self.listService.joined(separator: "\n- ")
            cell.lbListServices.text = "Chưa hài lòng bộ phận: "
            cell.lbServices.text = "- " + text
            cell.viewservices.isHidden = false
            cell.viewSorry.isHidden = true
            cell.viewRatingAgain.isHidden = true
        } else if indexPath.row == 0 {
            cell.viewservices.isHidden = true
            cell.viewSorry.isHidden = false
            cell.viewRatingAgain.isHidden = true
        } else if indexPath.row == 2 {
            cell.viewservices.isHidden = true
            cell.viewSorry.isHidden = true
            cell.viewRatingAgain.isHidden = false
            
        }
        cell.btDismis = {
//            self.dismiss(animated: true, completion: nil)
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewRatingAgain") as! ViewRatingAgain
                        vc.modalPresentationStyle = .overFullScreen
                        vc.listener = self
            //            vc.listService = self.listService
                        self.present(vc, animated: true, completion: nil)
        }
        cell.btYes = {
            self.dismiss(animated: true, completion: nil)
        }
        cell.btNoAction = {
            self.dismiss(animated: true, completion: nil)
        }
        
        cell.btEyesAction = {
            let index = IndexPath(row: 1, section: 0)
            self.collect.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
//        let screenSize = UIScreen.main.bounds.size
//        return screenSize
        //If you want to fit the size with the size of ViewController use bellow
        let viewControllerSize = self.view.frame.size
        return viewControllerSize
    }
    
    
}
extension ViewResultRatingSad: ViewRatingAgainAction {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
        self.listner?.dismissViewResultRatingSadListner()
    }
    
}
