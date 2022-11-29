//
//  WhishlistStorage.swift
//  edumax
//
//  Created by user231981 on 11/29/22.
//


import Foundation
import UIKit
import CoreData

final class WishlistStorage{
    func getCourseById(id:String) -> CourseModel?  {
        
        
        var list = self.getCourses();
        for course in list {
            if course._id == id{
                return course;
            }
        }
        return nil;
        
    }
    func getCourses() -> [CourseModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Whishlist")
        do {
            let result = try managedContext.fetch(fetchRequest)
            var list:[CourseModel] = []
            for obj in result {
                let course = CourseModel(
                    _id: obj.value(forKey: "id") as! String,
                    title: obj.value(forKey: "title") as! String,
                    description: obj.value(forKey: "desc") as! String,
                    price: obj.value(forKey: "price") as! String,
                    image: obj.value(forKey: "image") as! String
                );
                list.append(course);
            }
            return list;
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return [];
        }
        
    }
    
    func save(course:CourseModel) -> Void {
        let appD = UIApplication.shared.delegate as! AppDelegate
        let PC = appD.persistentContainer
        let managedContext = PC.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Whishlist",in: managedContext)!
        let object = NSManagedObject(entity: entity,insertInto: managedContext)
        
        object.setValue(course._id, forKey: "id")
        object.setValue(course.title, forKey: "title")
        object.setValue(course.description, forKey: "desc")
        object.setValue(course.price, forKey: "price")
        object.setValue(course.image, forKey: "image")
        
        
        do {
            try managedContext.save()
            print("Course added to Whishlist")
            //return 200
        } catch let error as NSError {
            print("Could not add. \(error), \(error.userInfo)")
            //return 500
        }
    }
    
    
    func deleteById(id:String) -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Whishlist")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for obj in result {
                let courseId =  obj.value(forKey: "id") as! String;
                if(courseId == id){
                    managedContext.delete(obj)
                }
                
            }
            try managedContext.save()
            print("deleted from whishlist")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
