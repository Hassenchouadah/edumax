//
//  UserModel.swift
//  edumax
//
//  Created by user231981 on 11/9/22.
//

import Foundation


struct UserModel: Codable {
    let _id: String
    let email: String
    let password: String
    let phone: String
    let avatar:String
    let verified:Int
    let token:String
}
