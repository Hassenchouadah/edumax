//
//  RegisterController.swift
//  edumax
//
//  Created by user231981 on 11/12/22.
//

import UIKit

class RegisterController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var phoneInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    
    var authService = AuthService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showAlertView(from vc: UIViewController?,message:String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vc?.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerToVerify" {
            let destination = segue.destination as! VerificationController
            destination.phone = self.phoneInput.text!
            destination.email=self.emailInput.text!
        }
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        if(firstNameInput.text?.count == 0){
            showAlertView(from: self, message: "Firstname is required")
            return;
        }
        if(lastNameInput.text?.count == 0){
            showAlertView(from: self, message: "Lastname is required")
            return;
        }
        if(emailInput.text?.count == 0){
            showAlertView(from: self, message: "email is required")
            return;
        }
        if(phoneInput.text?.count == 0){
            showAlertView(from: self, message: "phone is required")
            return;
        }
        if(passwordInput.text?.count == 0){
            showAlertView(from: self, message: "password is required")
            return;
        }
        if(confirmPasswordInput.text?.count == 0){
            showAlertView(from: self, message: "comfirm your password")
            return;
        }
        
        if(confirmPasswordInput.text! != passwordInput.text!){
            showAlertView(from: self, message: "password dont match")
            return;
        }
        
        authService.register(
            user: UserModel(_id: "", email: emailInput.text!, password: passwordInput.text!, phone: phoneInput.text!,avatar: "",verified: 0,token: "",firstName: firstNameInput.text!,lastName: lastNameInput.text!,role: "user"),
            onSuccess: {[weak self] (response) in
                DispatchQueue.main.async {
                    if(response.status==200){
                        self?.performSegue(withIdentifier: "registerToVerify", sender: sender)
                    }else{
                        self?.showAlertView(from: self, message: response.message)
                    }
                }
            },
            onError: {[weak self] (error) in
                DispatchQueue.main.async {
                    self?.showAlertView(from: self, message: error.localizedDescription)
                }
            })
        
        
        
    }
    
}
