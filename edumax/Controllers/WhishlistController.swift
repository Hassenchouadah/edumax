//
//  WhishlistController.swift
//  edumax
//
//  Created by user231981 on 11/29/22.
//

import UIKit
import SwiftUI

class WhishlistController: UIViewController {
    
    var whishlist:[CourseModel] = [];
    
    var ws = WishlistStorage();
    
    @IBOutlet weak var WishlistView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "courseCell")
        
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WishlistView.dataSource = self;
        WishlistView.delegate = self;
        whishlist = ws.getCourses();
        
        self.WishlistView.performBatchUpdates(
            {
                self.WishlistView.reloadSections(NSIndexSet(index: 0) as IndexSet)
            }, completion: { (finished:Bool) -> Void in
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        whishlist = ws.getCourses();
        
        self.WishlistView.performBatchUpdates(
            {
                self.WishlistView.reloadSections(NSIndexSet(index: 0) as IndexSet)
            }, completion: { (finished:Bool) -> Void in
            })
    }
    
    
    
    
}


extension WhishlistController :UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView==WishlistView{
            
            let vc = UIHostingController(rootView: CourseDetails(course: whishlist[indexPath.row] ));
            present(vc,animated: true);
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return whishlist.count
    }
    
    
    func buildCourseCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath)
        let contentView = cell.contentView
        
        contentView.layer.cornerRadius = 7
        contentView.layer.borderWidth = 0.4
        contentView.layer.borderColor = UIColor(red: 55/255, green: 59/255, blue: 100/255, alpha: 0.3).cgColor;
        
        let courseImage = contentView.viewWithTag(1) as! UIImageView
        let courseTitle = contentView.viewWithTag(2) as! UILabel
        let courseDescription = contentView.viewWithTag(3) as! UILabel
        let coursePrice = contentView.viewWithTag(4) as! UILabel
        
        
        courseImage.load(url: URL(string: "http://3.9.193.138:5001\(whishlist[indexPath.row].image)")!)
        courseImage.layer.cornerRadius = 12
        
        courseTitle.text = whishlist[indexPath.row].title
        courseDescription.text = whishlist[indexPath.row].description
        coursePrice.text = whishlist[indexPath.row].price
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return buildCourseCell(collectionView: collectionView, cellForItemAt: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height:131)
    }
}


