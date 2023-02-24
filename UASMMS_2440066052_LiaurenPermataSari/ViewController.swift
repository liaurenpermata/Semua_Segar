//
//  ViewController.swift
//  UASMMS_2440066052_LiaurenPermataSari
//
//  Created by prk on 03/02/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var txtFieldPassword: UITextField!
    @IBOutlet var txtFieldEmail: UITextField!
    
    var context: NSManagedObjectContext!
    var arrUser: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButton(_ sender: Any) {
        if(txtFieldEmail.text != "" && txtFieldPassword.text != ""){
            
            let email = txtFieldEmail.text
            let password = txtFieldPassword.text
            
            loadData()
            
            var flag: Int = 0
            
            for data in arrUser {
                if(data.email == email && data.password == password){
                    performSegue(withIdentifier: "goToMenu", sender: self)
                    flag = 1
                }
            }
            
            if flag == 0 {
                let alert = UIAlertController(title: "Login", message: "input the right email and password", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                present(alert, animated: true)
            }
        }
    }
    
    @IBAction func goToRegister(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
    func loadData(){
        arrUser.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            
            for data in result {
                let temp = User()
                temp.email = data.value(forKey: "email") as! String
                temp.password = data.value(forKey: "password") as! String
                
                arrUser.append(temp)
            }
        } catch {
            print("load data failed...")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMenu"{
            let dest = segue.destination as! HomeViewController
            dest.user.email = txtFieldEmail.text
            dest.user.password = txtFieldPassword.text
        }
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
}

