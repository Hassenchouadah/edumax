//
//  MentorDetailsController.swift
//  edumax
//
//  Created by user231981 on 1/2/23.
//

import UIKit
import SwiftUI

class MentorDetailsController: UIViewController {

    @IBOutlet weak var coverImg: UIImageView!
    
    @IBOutlet weak var mentorImg: UIImageView!
    
    @IBOutlet weak var fullnameText: UILabel!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsToChat" {
            let destination  = segue.destination as! ChatController
            destination.friend = sender as! UserModel
        }
    }
    @IBAction func openChat(_ sender: UIButton) {
        performSegue(withIdentifier: "DetailsToChat", sender: mentor)
    }
    
    @IBOutlet weak var coursesCollection: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "courseCell")
        
        return cv
    }()
    
    
    
    var mentor:UserModel = UserModel(_id: "639895dfb295869526bab291", email: "", password: "", phone: "", avatar: "", verified: 0, token: "", firstName: "Khaled", lastName: "Guedria", role: "")
    
    let courseService: CourseService = CourseService();
    var courses:[CourseModel] = []
    
    func fetchCourses() -> Void {
        courseService.getCoursesByMentor(id: mentor._id,onSuccess: {[self] (response) in
            DispatchQueue.main.async {
                self.courses = response
                print(courses.count)
                self.coursesCollection.reloadData();
            }
        }, onError: {(error) in
            DispatchQueue.main.async {
                print(error.localizedDescription)
            }
        })

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(mentor)
        fetchCourses()

        mentorImg.load(url: URL(string: "http://3.9.193.138:5001\(mentor.avatar)")!)
        coverImg.load(url: URL(string: "http://3.9.193.138:5001\(mentor.avatar)")!)
        fullnameText.text = mentor.firstName+" "+mentor.lastName
        
        coursesCollection.dataSource = self
        coursesCollection.delegate = self
        // Do any additional setup after loading the view.
    }
    


}


extension MentorDetailsController :UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIHostingController(rootView: CourseDetails(course: courses[indexPath.row] ));
        present(vc,animated: true);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 113, height: 145)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

  
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath)
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 0.4
        cell.layer.borderColor = UIColor(red: 55/255, green: 59/255, blue: 100/255, alpha: 1).cgColor
        let contentView = cell.contentView
        
        let backgroundView = contentView.viewWithTag(1) as! UIImageView
        
        //backgroundView.image = UIImage(named: "mesh-706.png")
        backgroundView.load(url: URL(string: "http://3.9.193.138:5001\(courses[indexPath.row].image)")!)

        //backgroundView.backgroundColor = .blue
        
        
        let title = contentView.viewWithTag(2) as! UILabel
        let subtitle = contentView.viewWithTag(3) as! UILabel
        
        title.text = courses[indexPath.row].title
        subtitle.text = courses[indexPath.row].price
        
        return cell
        
    }
    
    
    
}
