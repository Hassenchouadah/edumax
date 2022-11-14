//
//  ViewController.swift
//  edumax
//
//  Created by user231981 on 11/9/22.
//

import UIKit

//cmd + i to format file
class LoginController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    //    var viewModel = LoginViewModel()
    var authService = AuthService()
    var userStorage = UserStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //bindViewModel()
        
    }
    
    func showAlertView(from vc: UIViewController?,message:String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vc?.present(alertController, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToVerify" {
            let destination = segue.destination as! VerificationController
            let user = sender as! UserModel
            destination.phone = user.phone
            destination.email=user.email
        }
    }
    
    @IBAction func LoginAction(_ sender: UIButton) {
        
        //viewModel.LoginRequest(email: emailInput.text!, password: passwordInput.text!)
        if(emailInput.text?.count==0){
            showAlertView(from: self, message: "email is required")
        }
        
        if(passwordInput.text?.count==0){
            showAlertView(from: self, message: "password is required")
        }
        
        authService.login(email: emailInput.text!, password: passwordInput.text!, onSuccess: {[weak self] (response) in
            DispatchQueue.main.async {
                if(response.status==200){
                    if response.user?.verified==0{
                        self!.performSegue(withIdentifier: "loginToVerify", sender: response.user!)
                    }else{
                        self!.userStorage.save(user: response.user!)
                        self!.performSegue(withIdentifier: "loginToHome", sender: "")
                    }
                    
                }else{
                    self?.showAlertView(from: self, message: response.message)
                }
            }
        }, onError: {[weak self] (error) in
            DispatchQueue.main.async {
                self?.showAlertView(from: self, message: error.localizedDescription)
            }
        })
    }
    
}

