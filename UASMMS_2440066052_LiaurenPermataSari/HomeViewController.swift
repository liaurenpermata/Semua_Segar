//
//  HomeViewController.swift
//  UASMMS_2440066052_LiaurenPermataSari
//
//  Created by prk on 03/02/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableViewBuah: UITableView!
    
    var arrBuah = [[String: Any]]()
    var context: NSManagedObjectContext!
    var index: Int!
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)

        loadDataAPI()
        
        tableViewBuah.delegate = self
        tableViewBuah.dataSource = self

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBuah.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buahCell") as! BuahTableViewCell
        
        let nama = arrBuah[indexPath.row]["name"] as! String
        let famili = arrBuah[indexPath.row]["family"] as! String
        
        cell.buahTitle.text = nama
        cell.buahGenus.text = famili
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buahCell") as! BuahTableViewCell
        index = indexPath.row
        performSegue(withIdentifier: "goToDetails", sender: cell)
    }
    
    func loadDataAPI(){
        let url = URL(string: "https://fruityvice.com/api/fruit/all")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            let jsonBuah = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            self.arrBuah = jsonBuah
            
            DispatchQueue.main.async {
                self.tableViewBuah.reloadData()
            }
            
        }).resume()
    }
    
    @IBAction func likeAction(_ sender: Any) {
        performSegue(withIdentifier: "goToLike", sender: self)
    }
    
    @IBAction func profileButton(_ sender: Any) {
        performSegue(withIdentifier: "goToProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails"{
            let dest = segue.destination as! DetailsViewController
            dest.nutrition = self.arrBuah[index!]["nutritions"] as! [String: Double]
            dest.buahTemp.name = self.arrBuah[index!]["name"] as! String
            dest.buahTemp.family = self.arrBuah[index!]["family"] as! String
            dest.buahTemp.order = self.arrBuah[index!]["order"] as! String
            dest.buahTemp.genus = self.arrBuah[index!]["genus"] as! String
            dest.user = self.user
        } else if segue.identifier == "goToLike"{
            let dest = segue.destination as! LikeViewController
            dest.user = self.user
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
