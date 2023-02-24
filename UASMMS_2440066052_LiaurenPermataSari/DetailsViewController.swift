
//
//  DetailsViewController.swift
//  UASMMS_2440066052_LiaurenPermataSari
//
//  Created by prk on 04/02/23.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    @IBOutlet var familyBuahLabel: UILabel!
    @IBOutlet var genusBuahLabel: UILabel!
    @IBOutlet var orderBuahLabel: UILabel!
    @IBOutlet var nameBuahLabel: UILabel!
    
    @IBOutlet var carboValueLabel: UILabel!
    @IBOutlet var sugarValueLabel: UILabel!
    @IBOutlet var caloriesValueLabel: UILabel!
    @IBOutlet var fatValueLabel: UILabel!
    @IBOutlet var proteinValueLabel: UILabel!
    
    var user = User()
    let buahTemp = Buah()
    var arrLike:[Like] = []
    var nutrition:[String: Double]!
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
            tap.numberOfTapsRequired = 2
            view.addGestureRecognizer(tap)
        
        nameBuahLabel.text = buahTemp.name
        familyBuahLabel.text = buahTemp.family
        genusBuahLabel.text = buahTemp.genus
        orderBuahLabel.text = buahTemp.order
        carboValueLabel.text = "\(nutrition["carbohydrates"]!)"
        caloriesValueLabel.text = "\(nutrition["calories"]!)"
        fatValueLabel.text = "\(nutrition["fat"]!)"
        proteinValueLabel.text = "\(nutrition["protein"]!)"
        sugarValueLabel.text = "\(nutrition["sugar"]!)"
    }
    
    @objc func doubleTapped() {
        loadLike()
        
        var flag:Int = 0
        for data in arrLike {
            if data.email == user.email && data.password == user.password && data.buah == buahTemp.name {
                flag = 1
            }
        }
        
        if flag == 0{
            saveDataLike()
            let alert = UIAlertController(title: "Fruit Like", message: "fruit has been added", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Fruit Like", message: "fruit has been added to like before", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            present(alert, animated: true)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent{
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        
    }
    
    func saveDataLike(){
        let entity = NSEntityDescription.entity(forEntityName: "LikeEntity", in: context)
        
        let newLike = NSManagedObject(entity: entity!, insertInto: context)
        newLike.setValue(buahTemp.name, forKey: "nameBuah")
        newLike.setValue(user.email, forKey: "usernameBuah")
        newLike.setValue(user.password, forKey: "passwordBuah")
        
        do {
            try context.save()
            print("success save data")
        } catch {
            print("save like failed...")
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
