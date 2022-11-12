//
//  LoginViewModel.swift
//  edumax
//
//  Created by user231981 on 11/9/22.
//

import UIKit

class LoginViewModel {
    
    var loginResponse:LoginResponse;
    
    var authService = AuthService()
    
    var updateView: (() -> Void)?
    
    var errorHandling: ((Error) -> Void)?
    
    init() {
        loginResponse = LoginResponse(status:0,message:"",user: nil);
    }
        
    func showAlertView(from vc: UIViewController?,message:String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vc?.present(alertController, animated: true)
    }
    
    func LoginRequest(email:String,password:String) {
        
        authService.login(email: email, password: password, onSuccess: {[weak self] (response) in
            DispatchQueue.main.async {
                self?.loginResponse = response
                self?.updateView?()
            }
        }, onError: {[weak self] (error) in
            DispatchQueue.main.async {
                self?.errorHandling?(error)
            }
        });
        
    }
    
}
