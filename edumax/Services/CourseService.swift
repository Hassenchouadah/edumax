//
//  CourseService.swift
//  edumax
//
//  Created by user231981 on 11/15/22.
//

import Foundation


final class CourseService {
    private var baseURL: String="http://localhost:5001"
    private var userStorage = UserStorage()
    
    func getCourses(onSuccess: @escaping ([CourseModel]) -> Void, onError: @escaping (Error) -> Void) {
        
        let connectedUser = userStorage.getConnectedUser()
        guard let url = URL(string: baseURL+"/api/courses/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(connectedUser.token!)", forHTTPHeaderField: "authorization")
        
        
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
                let response = try decoder.decode([CourseModel].self, from: data)
                onSuccess(response)
                
            } catch let error {
                print("error: ", error)
            }
            
        }.resume()
    }

    func getCourseById(id:String,onSuccess: @escaping (CourseModel) -> Void, onError: @escaping (Error) -> Void) {
        
        let connectedUser = userStorage.getConnectedUser()
        guard let url = URL(string: baseURL+"/api/courses/"+id) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(connectedUser.token!)", forHTTPHeaderField: "authorization")
        
        
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
                let response = try decoder.decode(CourseModel.self, from: data)
                onSuccess(response)
                
            } catch let error {
                print("error: ", error)
            }
            
        }.resume()
    }
    func getCoursesByMentor(id:String,onSuccess: @escaping ([CourseModel]) -> Void, onError: @escaping (Error) -> Void) {
        
        let connectedUser = userStorage.getConnectedUser()
        guard let url = URL(string: baseURL+"/api/courses/getCoursesByMentor/"+id) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(connectedUser.token!)", forHTTPHeaderField: "authorization")
        
        
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
                let response = try decoder.decode([CourseModel].self, from: data)
                onSuccess(response)
                
            } catch let error {
                print("error: ", error)
            }
            
        }.resume()
    }

    
}
