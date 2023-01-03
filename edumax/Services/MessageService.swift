//
//  MessageService.swift
//  edumax
//
//  Created by user231981 on 12/13/22.
//


import Foundation

final class MessageService {
    private var baseURL: String="http://3.9.193.138:5001"
    private var userStorage = UserStorage()
    
    func getMessages(friendId:String,onSuccess: @escaping ([chatResponse]) -> Void, onError: @escaping (Error) -> Void) {
        
        let connectedUser = userStorage.getConnectedUser()
        
        

        
        
        
        let parameters = ["senderId" : friendId, "connectedId" : connectedUser._id]
        guard let url = URL(string: baseURL+"/api/chat/getMessages") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(connectedUser.token!)", forHTTPHeaderField: "authorization")
        
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
                let response = try decoder.decode([chatResponse].self, from: data)

                onSuccess(response)
                
            } catch let error {
                print("error: ", error)
            }
            
        }.resume()
    }
    
    
    func addMessage(friendId:String,type:String,msg:String,onSuccess: @escaping (BackendResponse) -> Void, onError: @escaping (Error) -> Void) {
        
        let connectedUser = userStorage.getConnectedUser()

        
        
        let parameters = ["sender" : connectedUser._id,"receiver" : friendId,"type": type,"message": msg]
        guard let url = URL(string: self.baseURL+"api/chat/addMessage") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(connectedUser.token!)", forHTTPHeaderField: "authorization")
        
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
                let response = try decoder.decode(BackendResponse.self, from: data)
                onSuccess(response)
                
            } catch let error {
                print("error: ", error)
            }
            
        }.resume()
    }
    
    

}

