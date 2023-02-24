//
//  LikeViewController.swift
//  UASMMS_2440066052_LiaurenPermataSari
//
//  Created by prk on 08/02/23.
//

import UIKit
import CoreData

class LikeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewLike: UITableView!
    
    var context: NSManagedObjectContext!
    var user = User()
    var arrLike:[Like] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        tableViewLike.delegate = self
        tableViewLike.dataSource = self
        
        loadLike()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLike.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewLike.dequeueReusableCell(withIdentifier: "likeCell") as! LikeTableViewCell
        cell.personLike.text = arrLike[indexPath.row].email!
        cell.buahLike.text = arrLike[indexPath.row].buah!
        
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent{
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func loadLike(){
        arrLike.removeAll()

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LikeEntity")

        do {
            let result = try context.fetch(request) as! [NSManagedObject]

            for data in result {
                let temp = Like()
                temp.email = data.value(forKey: "usernameBuah") as! String
                temp.buah = data.value(forKey: "nameBuah") as! String
                temp.password = data.value(forKey: "passwordBuah") as! String

                if(temp.email == user.email && temp.password == user.password){
                    print("success add data to array")
                    arrLike.append(temp)
                }
            }

        } catch {
            print("load data like failed...")
        }
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
