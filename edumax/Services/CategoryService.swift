//
//  CategoryService.swift
//  edumax
//
//  Created by user231981 on 11/15/22.
//

import Foundation

final class CategoryService {
    private var baseURL: String="http://3.9.193.138:5001"
    private var userStorage = UserStorage()
    
    func getCategories(onSuccess: @escaping ([CategoryModel]) -> Void, onError: @escaping (Error) -> Void) {
        
        let connectedUser = userStorage.getConnectedUser()
        guard let url = URL(string: baseURL+"/api/categories/") else { return }
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
                let response = try decoder.decode([CategoryModel].self, from: data)
                onSuccess(response)
                
            } catch let error {
                print("error: ", error)
            }
            
        }.resume()
    }

}
