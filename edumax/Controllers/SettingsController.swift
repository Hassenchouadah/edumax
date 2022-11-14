//
//  SettingsController.swift
//  edumax
//
//  Created by user231981 on 11/14/22.
//

import UIKit

class SettingsController: UIViewController {

    var userStorage = UserStorage()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func logoutAction(_ sender: UIButton) {
        userStorage.delete()
        performSegue(withIdentifier: "settingsToLogin", sender: sender)
    }
    
}
