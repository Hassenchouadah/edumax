//
//  AuthServiceProtocol.swift
//  edumax
//
//  Created by user231981 on 11/9/22.
//

import Foundation

protocol AuthServiceProtocol {
    func login(email:String,password:String,onSuccess: @escaping (LoginResponse) -> Void, onError: @escaping (Error) -> Void)
}
