//
//  HomeController.swift
//  edumax
//
//  Created by user231981 on 11/14/22.
//

import UIKit

class HomeController: UIViewController {
    
    
    var categories = [CategoryModel]()
    var selectedCategory = "";
    
    @IBOutlet weak var categoryView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        return cv
    }()
    
    @IBOutlet weak var mentorsView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "mentorCell")
        
        return cv
    }()
    
    
    @IBOutlet weak var PromotionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "promotionCell")
        
        return cv
    }()
    
    @IBOutlet weak var coursesView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "courseCell")
        
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PromotionView.delegate = self
        PromotionView.dataSource = self
        
        mentorsView.delegate = self
        mentorsView.dataSource = self
        
        categoryView.delegate = self
        categoryView.dataSource = self

        coursesView.delegate = self
        coursesView.dataSource = self

        
        
        categories = [
            CategoryModel(_id: "1", title: "All"),
            CategoryModel(_id: "2", title: "Chemistry"),
            CategoryModel(_id: "3", title: "IT"),
            CategoryModel(_id: "4", title: "Business")
        ]
        selectedCategory = categories.first!._id;
        
        // Do any additional setup after loading the view.
    }
    
    
}



extension HomeController :UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView==categoryView {
            
            selectedCategory = categories[indexPath.row]._id
            self.categoryView.performBatchUpdates(
                {
                    self.categoryView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                }, completion: { (finished:Bool) -> Void in
                })
            print(selectedCategory)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == PromotionView){
            return 2
        } else if collectionView == mentorsView{
            return 6;
        }else if collectionView == categoryView{
            return categories.count
        }else{
            return 6
        }
    }
    
    func buildPromotioncell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "promotionCell", for: indexPath)
        let contentView = cell.contentView
        
        let backgroundView = contentView.viewWithTag(5) as! UIImageView
        backgroundView.image = UIImage(named: "mesh-706.png")
        //backgroundView.backgroundColor = .blue

        backgroundView.layer.cornerRadius = 18
        let titlep = contentView.viewWithTag(1) as! UILabel
        let subtitlep = contentView.viewWithTag(2) as! UILabel
        let descriptionp = contentView.viewWithTag(3) as! UILabel
        let percentagep = contentView.viewWithTag(4) as! UILabel
        
        titlep.text = "50% OFF"
        subtitlep.text = "Tomorrow's Special"
        descriptionp.text = "Get a discount of"
        percentagep.text = "50%"
        
        return cell
    }
    
    func buildMentorCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mentorCell", for: indexPath)
        let contentView = cell.contentView
        
        
        let mentorImage = contentView.viewWithTag(1) as! UIImageView
        let mentorName = contentView.viewWithTag(2) as! UILabel
        
        mentorName.text = "Hassen"
        mentorImage.image = UIImage(named: "profile.jpeg")
        mentorImage.layer.cornerRadius = mentorImage.bounds.width/2
        
        
        
        return cell
    }
    
    func buildCategoryCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
        let contentView = cell.contentView
        
        
        let categoryView = contentView.viewWithTag(1) as! UIView
        let categoryName = contentView.viewWithTag(2) as! UILabel
        
        categoryName.text = categories[indexPath.row].title
        
        categoryView.layer.cornerRadius = 10
        
        if(categories[indexPath.row]._id==selectedCategory){
            categoryName.textColor = .white;
            categoryView.backgroundColor = .blue;
        }else{
            categoryName.textColor = .blue;
            categoryView.backgroundColor = .white;
            categoryView.layer.borderWidth = 0.4
            categoryView.layer.borderColor = UIColor(red: 55/255, green: 59/255, blue: 100/255, alpha: 1).cgColor;
            
        }
        return cell
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

        
        courseImage.image = UIImage(named: "profile.jpeg")
        courseImage.layer.cornerRadius = 12
        
        courseTitle.text = "Design illustration"
        courseDescription.text = "Design illustration 3D"
        coursePrice.text = "45$"
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView==PromotionView){
            return buildPromotioncell(collectionView: collectionView, cellForItemAt: indexPath)
        }else if (collectionView == mentorsView){
            return buildMentorCell(collectionView: collectionView, cellForItemAt: indexPath)
        }else if collectionView == categoryView{
            return buildCategoryCell(collectionView: collectionView, cellForItemAt: indexPath)
        }else{
            return buildCourseCell(collectionView: collectionView, cellForItemAt: indexPath)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == PromotionView){
            return CGSize(width: 326, height:159)
        }else if(collectionView == mentorsView){
            return CGSize(width: 76, height:102)
        }else if collectionView == categoryView{
            return CGSize(width: 128, height:44)
        }else{
            return CGSize(width: 300, height:131)
        }
    }
}
