//
//  AuthService.swift
//  edumax
//
//  Created by user231981 on 11/9/22.
//

import Foundation

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case noData
}

import Foundation

final class AuthService: AuthServiceProtocol {
    
    private var baseURL: String="http://localhost:5000"
    
    func login(email:String,password:String,onSuccess: @escaping (LoginResponse) -> Void, onError: @escaping (Error) -> Void) {
        makeLoginRequest(with: "/api/auth/login",email:email,password:password ,onSuccess: onSuccess, onError: onError)
    }
    
    func register(user:UserModel,onSuccess: @escaping (BackendResponse) -> Void, onError: @escaping (Error) -> Void) {
        let parameters = [
            "email" : user.email,
            "phone" : user.phone,
            "password" : user.password,
        ]
        guard let url = URL(string: baseURL+"/api/auth/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                onError(error)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            guard let data = data else {
                onError(NetworkError.invalidResponse)
                return
            }
            
            do {
                let loginResponse = try decoder.decode(BackendResponse.self, from: data)
                onSuccess(loginResponse)
                
            } catch let error {
                print("error: ", error)
            }
            
        }.resume()
    }
    
    func sendVerificationCode(email:String,code:Int,onSuccess:@escaping (BackendResponse) -> Void, onError: @escaping (Error) -> Void) -> Void {
        let parameters = [
            "email" : email,
            "verificationCode" : String(code)
        ]
        guard let url = URL(string: baseURL+"/api/auth/sendVerificationCode") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if let error = error {
                onError(error)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            guard let data = data else {
                onError(NetworkError.invalidResponse)
                return
            }
            
            do {
                let loginResponse = try decoder.decode(BackendResponse.self, from: data)
                onSuccess(loginResponse)
                
            } catch let error {
                print("error: ", error)
            }
        }.resume()

    }
    
    
    
    private func makeLoginRequest(with route: String,email:String,password:String, onSuccess: @escaping (LoginResponse) -> Void, onError: @escaping (Error) -> Void) {
        
        
        let parameters = ["email" : email, "password" : password]
        guard let url = URL(string: baseURL+route) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                onError(error)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            guard let data = data else {
                onError(NetworkError.invalidResponse)
                return
            }
            
            do {
                
                
                
                let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                
                //                guard loginResponse.count > 0 else {
                //                    onError(NetworkError.noData)
                //                    return
                //                }
                
                onSuccess(loginResponse)
                
            } catch let error {
                print("error: ", error)
            }
            
        }.resume()
        
    }
}