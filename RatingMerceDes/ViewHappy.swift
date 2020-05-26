//
//  ViewHappy.swift
//  RatingMerceDes
//
//  Created by MacbookPro on 5/21/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

protocol ViewHappyListner {
    func dismissViewHappyListner()
}

class ViewHappy: UIViewController {
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
    var listner: ViewHappyListner?
    var veticalbtregister: [NSLayoutConstraint]?
    var hozrizontalbtregister: [NSLayoutConstraint]?
    //add UIPageControl
    var page_control: UIPageControl!
    //add button next
    var next_button: UIButton!
    //add button skip
    var skip_button: UIButton!
    var next_top: NSLayoutConstraint!
    var pre_top: NSLayoutConstraint!
    var previous_button: UIButton!
    var page_bottom: NSLayoutConstraint!
    var array_page: [page] = [page]()
    var btDismissAction: UIButton = UIButton(type: .custom)
    @IBOutlet weak var btDismiss: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        self.view.addSubview(collect)
        
        collect.delegate = self
        collect.dataSource = self
        
        let cellNib = UINib(nibName: "ViewHappyCell", bundle: nil)
        self.collect.register(cellNib, forCellWithReuseIdentifier: "cell")
        
        
        collect.translatesAutoresizingMaskIntoConstraints = false
        veticalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "V:|-180-[v0]-111-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect ])
        hozrizontalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect ])
        view.addConstraints(veticalbtregister!)
        view.addConstraints(hozrizontalbtregister!)
//        collect.backgroundColor = .red
        collect.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        create_array_page()
        page_control_setup_autolayout()
        next_button = UIButton(type: .system)
        next_button.setImage(UIImage(named: "next_button"), for: .normal)
               next_button.addTarget(self, action: #selector(next_page), for: .touchUpInside)
               self.view.addSubview(next_button)
               
               next_button.translatesAutoresizingMaskIntoConstraints = false
               next_top = next_button.centerYAnchor.constraint(equalTo: self.collect.centerYAnchor, constant: 0)
               next_top.isActive = true
               next_button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -120).isActive = true
               next_button.widthAnchor.constraint(equalToConstant: 27).isActive = true
               next_button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        previous_button = UIButton(type: .system)
        previous_button.setImage(UIImage(named: "ic_previous_light"), for: .normal)
        previous_button.addTarget(self, action: #selector(previous_page), for: .touchUpInside)
        self.view.addSubview(previous_button)
        
        previous_button.translatesAutoresizingMaskIntoConstraints = false
        pre_top = previous_button.centerYAnchor.constraint(equalTo: self.collect.centerYAnchor, constant: 0)
        pre_top.isActive = true
        previous_button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 120).isActive = true
        previous_button.widthAnchor.constraint(equalToConstant: 27).isActive = true
        previous_button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.view.addSubview(btDismissAction)
        
        btDismissAction.setImage(UIImage(named: "ic_back"), for: .normal)
        btDismissAction.addTarget(self, action: #selector(actionDismiss), for: .touchUpInside)
        btDismissAction.translatesAutoresizingMaskIntoConstraints = false
        btDismissAction.topAnchor.constraint(equalTo: self.page_control.topAnchor, constant: 25).isActive = true
        btDismissAction.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -115).isActive = true
        btDismissAction.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btDismissAction.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    @objc func actionDismiss() {
//        self.dismiss(animated: true, completion: nil)
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewRatingAgain") as! ViewRatingAgain
                      vc.modalPresentationStyle = .overFullScreen
                      vc.listener = self
          //            vc.listService = self.listService
                      self.present(vc, animated: true, completion: nil)
    }
    @objc func next_page(){
        //Nếu là page cuối thì không làm gì cả
        if page_control.currentPage == self.array_page.count {
            return
        }
        previous_button.setImage(UIImage(named: "previous_button"), for: .normal)
        //check nếu là page kế cuối
        if page_control.currentPage == self.array_page.count - 1 {
            //               page_bottom.constant = 40
            //               skip_top.constant = -40
//            next_top.constant = -40
            next_button.setImage(UIImage(named: "ic_next_light"), for: .normal)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        let indexPath = IndexPath(item: page_control.currentPage + 1, section: 0)
        self.collect.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        page_control.currentPage += 1
    }
        @objc func previous_page(){
               //Nếu là page đầu thì không làm gì cả
               if page_control.currentPage == 0 {
                
                   return
               }
            next_button.setImage(UIImage(named: "next_button"), for: .normal)
            if page_control.currentPage == 1 {
                        //               page_bottom.constant = 40
                        //               skip_top.constant = -40
            //            next_top.constant = -40
//                        next_button.setImage(UIImage(named: "ic_next_light"), for: .normal)
                previous_button.setImage(UIImage(named: "ic_previous_light"), for: .normal)
                        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                            self.view.layoutIfNeeded()
                        }, completion: nil)
                    }
               let indexPath = IndexPath(item: page_control.currentPage - 1, section: 0)
               self.collect.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
               page_control.currentPage -= 1
           }
    func create_array_page(){
        let page1 = page(image: "1", title: "AAAAAAAAAAAA", des: "AAAAAAAAAAAA22222222222222222222222222222222222222222222222222222222222222")
        let page2 = page(image: "2", title: "22222222222222222", des: "22222222222222222222222222222222222222222222222222222222222222")
        let page3 = page(image: "1", title: "AAAAAAAAAAAA", des: "AAAAAAAAAAAA22222222222222222222222222222222222222222222222222222222222222")
        let page4 = page(image: "2", title: "22222222222222222", des: "22222222222222222222222222222222222222222222222222222222222222")
        self.array_page.append(page1)
        self.array_page.append(page2)
        self.array_page.append(page3)
        self.array_page.append(page4)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            view.removeConstraints(veticalbtregister!)
            view.removeConstraints(hozrizontalbtregister!)
            veticalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "V:|-180-[v0]-111-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect])
            hozrizontalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect])
            view.addConstraints(veticalbtregister!)
            view.addConstraints(hozrizontalbtregister!)
            collect.reloadData()
        } else {
            view.removeConstraints(veticalbtregister!)
            view.removeConstraints(hozrizontalbtregister!)
            veticalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "V:|-180-[v0]-111-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect])
            hozrizontalbtregister = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":collect])
            view.addConstraints(veticalbtregister!)
            view.addConstraints(hozrizontalbtregister!)
            collect.reloadData()
        }
    }
    //setup & autolayout page control
       func page_control_setup_autolayout(){
           page_control = UIPageControl()
           //        page_control.backgroundColor = UIColor.lightGray
           page_control.pageIndicatorTintColor = .lightGray
           page_control.currentPageIndicatorTintColor = #colorLiteral(red: 0.1882352941, green: 0.7019607843, blue: 1, alpha: 1)
           page_control.numberOfPages = array_page.count + 1
           self.view.addSubview(page_control)
           
           page_control.translatesAutoresizingMaskIntoConstraints = false
           page_control.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
           page_bottom = page_control.topAnchor.constraint(equalTo: self.btDismiss.topAnchor, constant: 0)
           page_bottom.isActive = true
           page_control.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
           page_control.heightAnchor.constraint(equalToConstant: 50).isActive = true
       }

    @IBAction func action(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewRatingAgain") as! ViewRatingAgain
                    vc.modalPresentationStyle = .overFullScreen
                    vc.listener = self
        //            vc.listService = self.listService
                    self.present(vc, animated: true, completion: nil)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override var shouldAutorotate: Bool {
        return true
    }
}
extension ViewHappy: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ViewHappyCell
        switch indexPath.row {
        case 0:
            cell.imgCener.image = UIImage(named: "ss_1_1")
            cell.vTks.isHidden = true
            cell.vImage.isHidden = false
        case 1:
            cell.imgCener.image = UIImage(named: "ss_2_2")
            cell.vTks.isHidden = true
            cell.vImage.isHidden = false
        case 2:
            cell.imgCener.image = UIImage(named: "ss_3_3")
            cell.vTks.isHidden = true
            cell.vImage.isHidden = false
        case 3:
            cell.imgCener.image = UIImage(named: "ss_4_2")
            cell.imgLeft.image = UIImage(named: "ss_4_1")
            cell.imgRight.image = UIImage(named: "ss_4_3")
        default:
            cell.vTks.isHidden = false
            cell.vImage.isHidden = true
        }
        if indexPath.row == 3 {
            cell.imgLeft.isHidden = false
            cell.imgRight.isHidden = false
            cell.vImageLeft.constant = 150
            cell.vImageRight.constant = 150
        } else {
            cell.imgLeft.isHidden = true
            cell.imgRight.isHidden = true
            cell.vImageLeft.constant = 0
            cell.vImageRight.constant = 0
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
//        let screenSize = UIScreen.main.bounds.size
//        return screenSize
        //If you want to fit the size with the size of ViewController use bellow
        let viewControllerSize = self.collect.frame.size
        return CGSize(width: viewControllerSize.width, height: viewControllerSize.height - 100)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //Hiển thị page curent
        var page_number = targetContentOffset.pointee.x / self.view.frame.width
        page_control.currentPage = Int(page_number)
        //Check view hiển thị khi cell là cuối cùng
        if page_number == CGFloat(array_page.count) {
//            page_bottom.constant = -80
//            skip_top.constant = -40
//            next_top.constant = -40
            next_button.setImage(UIImage(named: "ic_next_light"), for: .normal)
            previous_button.setImage(UIImage(named: "previous_button"), for: .normal)
        } else if page_number == 0  {
//            page_bottom.constant = -80
//            skip_top.constant = 10
//            next_top.constant = 10
            next_button.setImage(UIImage(named: "next_button"), for: .normal)
            previous_button.setImage(UIImage(named: "ic_previous_light"), for: .normal)
        } else {
            previous_button.setImage(UIImage(named: "previous_button"), for: .normal)
            next_button.setImage(UIImage(named: "next_button"), for: .normal)
        }
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
}
class page {
    var image: String!
    var title: String!
    var des: String
    init(image: String, title: String, des: String) {
        self.image = image
        self.title = title
        self.des = des
    }
}

extension ViewHappy: ViewRatingAgainAction {
    func dismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true, completion: nil)
            self.listner?.dismissViewHappyListner()
        }
        
    }
    
    
}
