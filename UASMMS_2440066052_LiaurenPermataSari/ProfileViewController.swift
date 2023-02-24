//
//  ProfileViewController.swift
//  UASMMS_2440066052_LiaurenPermataSari
//
//  Created by prk on 08/02/23.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent{
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    
    @IBAction func logOutButton(_ sender: Any) {
        performSegue(withIdentifier: "backToLogin", sender: self)
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
