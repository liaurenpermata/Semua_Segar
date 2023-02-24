//
//  RegisterViewController.swift
//  UASMMS_2440066052_LiaurenPermataSari
//
//  Created by prk on 03/02/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet var txtFieldConfirm: UITextField!
    @IBOutlet var txtFieldPassword: UITextField!
    @IBOutlet var txtFieldEmail: UITextField!
    
    var context: NSManagedObjectContext!
    var arrUser:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        performSegue(withIdentifier: "backToLogin", sender: self)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        if(txtFieldEmail.text != "" && txtFieldPassword.text != "" && txtFieldPassword.text == txtFieldConfirm.text){
            
            loadData()
            var flag:Int = 0
            for data in arrUser {
                if data.email == txtFieldEmail.text && data.password == txtFieldPassword.text {
                    flag = 1
                }
            }
            
            if flag == 0 {
                userSaveSQL()
                performSegue(withIdentifier: "backToLogin", sender: self)
            } else {
                let alert = UIAlertController(title: "Register", message: "you've registered. please go to login", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Register", message: "please fill the email and password correctly", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            present(alert, animated: true)
        }
    }
    
    
    
    func userSaveSQL(){
        let email = txtFieldEmail.text!
        let password = txtFieldPassword.text!
        
        let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(email, forKey: "email")
        newUser.setValue(password, forKey: "password")
        
        do{
            try context.save()
        } catch {
            print("save failed...")
        }
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
}
