//
//  LoginResponse.swift
//  edumax
//
//  Created by user231981 on 11/9/22.
//

import Foundation

struct LoginResponse: Codable {
    let status:Int
    let message: String
    let user: UserModel?
}
