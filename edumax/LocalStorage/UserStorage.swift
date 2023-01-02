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
    func getConnectedUser() -> UserModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        var connectedUser = UserModel(_id: "", email: "", password: "", phone: "", avatar: "", verified: 0, token: "",firstName: "",lastName: "",role: "")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for obj in result {
                /*connectedUser = UserModel(
                    _id: (obj.value(forKey: "id") as! String),
                    email: (obj.value(forKey: "email") as! String),
                    password: (obj.value(forKey: "password") as! String),
                    phone: (obj.value(forKey: "phone") as! String),
                    avatar: (obj.value(forKey: "avatar") as! String),
                    verified: (obj.value(forKey: "verified") as! Int),
                    token: (obj.value(forKey: "token") as! String)
                )*/
                connectedUser = UserModel(
                    _id: (obj.value(forKey: "id") as! String),
                    email: (obj.value(forKey: "email") as! String),
                    password: (obj.value(forKey: "password") as! String),
                    phone: (obj.value(forKey: "phone") as! String),
                    avatar: (obj.value(forKey: "avatar") as! String),
                    verified: (obj.value(forKey: "verified") as! Int),
                    token: (obj.value(forKey: "token") as! String),
                    firstName: (obj.value(forKey: "firstName") as! String),
                    lastName: (obj.value(forKey: "lastName") as! String),
                    role: (obj.value(forKey: "role") as! String))
            }
            return connectedUser;
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return connectedUser;
        }
        
    }
    
    func save(user:UserModel) -> Void {
        print("user before save")
        print(user)
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
        object.setValue(user.token, forKey: "token")
        
        object.setValue(user.firstName, forKey: "firstName")
        object.setValue(user.lastName, forKey: "lastName")
        object.setValue(user.role, forKey: "role")
        
        
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
