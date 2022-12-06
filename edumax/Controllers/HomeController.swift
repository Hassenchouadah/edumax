//
//  HomeController.swift
//  edumax
//
//  Created by user231981 on 11/14/22.
//

import UIKit
import SwiftUI

class HomeController: UIViewController {
    
    
    var categories = [CategoryModel]()
    var mentors = [MentorModel]()
    var promotions = [PromotionModel]()
    var courses = [CourseModel]()
    

    var selectedCategory = "";
    
    var mentorService = MentorService()
    var categoryService = CategoryService()
    var promotionService = PromotionService()
    var courseService = CourseService()
    var userStorage = UserStorage()
    
    @IBOutlet weak var FullName: UILabel!
    
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
    
    func showAlertView(from vc: UIViewController?,message:String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vc?.present(alertController, animated: true)
    }
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    @IBAction func redirectToCourses(_ sender: UIButton) {
        let vc = UIHostingController(rootView: CoursesView());
        present(vc,animated: true);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        FullName.text = userStorage.getConnectedUser().email
        avatarImg.load(url: URL(string: "http://localhost:5001\(userStorage.getConnectedUser().avatar)")!)
        PromotionView.delegate = self
        PromotionView.dataSource = self
        
        mentorsView.delegate = self
        mentorsView.dataSource = self
        
        categoryView.delegate = self
        categoryView.dataSource = self
        
        coursesView.delegate = self
        coursesView.dataSource = self
        
        
        categoryService.getCategories(onSuccess: {[weak self] (response) in
            DispatchQueue.main.async {
                self!.categories = response
                self!.selectedCategory = response.first!._id
                self!.categoryView.reloadData()
            }
        }, onError: {[weak self] (error) in
            DispatchQueue.main.async {
                self?.showAlertView(from: self, message: error.localizedDescription)
            }
        })
        
        mentorService.getMentors(onSuccess: {[weak self] (response) in
            DispatchQueue.main.async {
                self!.mentors = response
                self!.mentorsView.reloadData()
            }
        }, onError: {[weak self] (error) in
            DispatchQueue.main.async {
                self?.showAlertView(from: self, message: error.localizedDescription)
            }
        })
        
        promotionService.getPromotions(onSuccess: {[weak self] (response) in
            DispatchQueue.main.async {
                self!.promotions = response
                self!.PromotionView.reloadData()
            }
        }, onError: {[weak self] (error) in
            DispatchQueue.main.async {
                self?.showAlertView(from: self, message: error.localizedDescription)
            }
        })
        
        courseService.getCourses(onSuccess: {[weak self] (response) in
            DispatchQueue.main.async {
                self!.courses = response
                self!.coursesView.reloadData()
            }
        }, onError: {[weak self] (error) in
            DispatchQueue.main.async {
                self?.showAlertView(from: self, message: error.localizedDescription)
            }
        })
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
}



extension HomeController :UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView==coursesView{
            
            let vc = UIHostingController(rootView: CourseDetails(course: courses[indexPath.row] ));
            present(vc,animated: true);
            
        }
        if collectionView==categoryView {
            
            
            selectedCategory = categories[indexPath.row]._id
            self.categoryView.performBatchUpdates(
                {
                    self.categoryView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                }, completion: { (finished:Bool) -> Void in
                })        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == PromotionView){
            return promotions.count
        } else if collectionView == mentorsView{
            return mentors.count;
        }else if collectionView == categoryView{
            return categories.count
        }else{
            return courses.count
        }
    }
    
    func buildPromotioncell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "promotionCell", for: indexPath)
        let contentView = cell.contentView
        
        let backgroundView = contentView.viewWithTag(5) as! UIImageView
        
        //backgroundView.image = UIImage(named: "mesh-706.png")
        backgroundView.load(url: URL(string: "http://localhost:5001\(promotions[indexPath.row].image)")!)

        //backgroundView.backgroundColor = .blue
        
        backgroundView.layer.cornerRadius = 18
        let titlep = contentView.viewWithTag(1) as! UILabel
        let subtitlep = contentView.viewWithTag(2) as! UILabel
        let descriptionp = contentView.viewWithTag(3) as! UILabel
        let percentagep = contentView.viewWithTag(4) as! UILabel
        
        titlep.text = promotions[indexPath.row].title
        subtitlep.text = promotions[indexPath.row].subtitle
        descriptionp.text = promotions[indexPath.row].description
        percentagep.text = promotions[indexPath.row].percentage
        
        return cell
    }
    
    func buildMentorCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mentorCell", for: indexPath)
        let contentView = cell.contentView
        
        
        let mentorImage = contentView.viewWithTag(1) as! UIImageView
        let mentorName = contentView.viewWithTag(2) as! UILabel
        
        mentorName.text = mentors[indexPath.row].firstName
        //mentorImage.image = UIImage(named: "profile.jpeg")
        mentorImage.load(url: URL(string: "http://localhost:5001"+mentors[indexPath.row].avatar)! )
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
            categoryView.backgroundColor = .systemIndigo;
        }else{
            categoryName.textColor = .systemIndigo;
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
        
        
        courseImage.load(url: URL(string: "http://localhost:5001\(courses[indexPath.row].image)")!)
        courseImage.layer.cornerRadius = 12
        
        courseTitle.text = courses[indexPath.row].title
        courseDescription.text = courses[indexPath.row].description
        coursePrice.text = courses[indexPath.row].price
        
        
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

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
