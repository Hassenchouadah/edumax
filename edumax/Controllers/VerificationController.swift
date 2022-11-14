//
//  VerificationController.swift
//  edumax
//
//  Created by user231981 on 11/12/22.
//

import UIKit

class VerificationController: UIViewController {
    
    var phone:String = ""
    var email:String = ""
    
    var generatedCode:Int=0
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var codeField: OneTimeCodeTextField!
    var authService = AuthService()
    var userStorage = UserStorage()
    
    func showAlertView(from vc: UIViewController?,message:String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vc?.present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let randomPattern = Int.random(in: 100000...999999)
        generatedCode = randomPattern
        print(randomPattern)
        /*authService.sendVerificationCode(phone: phone, code: randomPattern, onSuccess: {[weak self] (response) in
            DispatchQueue.main.async {
                if(response.status==200){
                    print("code sent")
                }else{
                    self?.showAlertView(from: self, message:response.message)
                }
            }
        }, onError: {[weak self] (error) in
            DispatchQueue.main.async {
                self?.showAlertView(from: self, message: error.localizedDescription)
            }
        })*/
        
        //setup loader
        loadingIndicator.alpha = 0
        loadingIndicator.hidesWhenStopped = true
        
        //setup verification field
        codeField.becomeFirstResponder()
        codeField.defaultCharacter = "-"
        codeField.configure()
        
        codeField.didEnterLastDigit = { [weak self] code in
            
            self?.loadingIndicator.alpha = 1
            self?.loadingIndicator.startAnimating()
            
            if code==String(self!.generatedCode) {
                print("correct code")
                self!.authService.verifyAccount(
                    email: self!.email,
                    onSuccess: {[weak self] (response) in
                        DispatchQueue.main.async {
                            self?.userStorage.save(user: response)
                            self?.performSegue(withIdentifier: "verifyToHome", sender: "")
                        }
                    }, onError: {[weak self] (error) in
                        DispatchQueue.main.async {
                            self?.showAlertView(from: self, message: error.localizedDescription)
                        }
                    })
            }else{
                self!.loadingIndicator.stopAnimating()
                let alert = UIAlertController(title: "Wrong code", message: "Wrong verification code ,please check your email", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self!.present(alert, animated: true)
            }
            
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
