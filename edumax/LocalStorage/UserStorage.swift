//
//  UserStorage.swift
//  edumax
//
//  Created by user231981 on 11/14/22.
//

import Foundation
import UIKit
import CoreData

final class UserStorage{
    func save(user:UserModel) -> Void {
        let appD = UIApplication.shared.delegate as! AppDelegate
        let PC = appD.persistentContainer
        let managedContext = PC.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users",in: managedContext)!
        let object = NSManagedObject(entity: entity,insertInto: managedContext)
        
        object.setValue(user._id, forKey: "id")
        object.setValue(user.email, forKey: "email")
        object.setValue(user.password, forKey: "password")
        object.setValue(user.phone, forKey: "phone")
        object.setValue(user.avatar, forKey: "avatar")
        object.setValue(user.verified, forKey: "verified")
        object.setValue(user.accessToken, forKey: "accessToken")
        
        
        do {
            try managedContext.save()
            print("user saved")
            //return 200
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            //return 500
        }
    }
    
    
    func delete() -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
        let managedContext = appDelegate.persistentContainer.viewContext
            
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
            
        do {
            let result = try managedContext.fetch(fetchRequest)
            for obj in result {
                managedContext.delete(obj)
            }
            try managedContext.save()
            print("deleted connected user")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
