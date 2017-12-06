//
//  DataUserTableViewController.swift
//  DataSiswaIDNApps
//
//  Created by Nando Septian Husni on 18/11/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON


class DataUserTableViewController: UITableViewController {
    
    var emailSelected:String?
    var namaSelected:String?
    var passwordSelected:String?
    var tglSelected:String?
    

    var siswa = [Siswa]()
    var arrKar = [[String: AnyObject]]()//array data siswa
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //memanggil data json menggunakan alamofire
        Alamofire.request("http://localhost/DataSiswaServer/index.php/Api/getUser").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.arrKar = resData as! [[String:AnyObject]]
                }
                if self.arrKar.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrKar.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserTableViewCell
        
        // Configure the cell...
        var dict = arrKar[indexPath.row]
        cell.username.text = dict["username"] as? String
        cell.email.text = dict["email"] as? String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        print("Row \(indexPath.row)selected")
        
        let task = arrKar[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        emailSelected = task["email"] as? String
        //  gambarSelcetd = task["gambar"] as! String
        namaSelected = task["username"] as? String
        
        
        performSegue(withIdentifier: "passData", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak`
        if segue.identifier == "passData"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            //        let kirimData = segue.destination as! KontakViewController
            //mengirimkan data ke masing2 variable
            //mengirimkan nama wisata
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! WelcomeViewController
                let value = arrKar[indexPath.row]
                
                controller.passEmail = value["email"] as? String
                controller.passUsername = value["username"] as? String
                controller.passPassword = value["password"] as? String
                controller.passTgldaftar = value["tgl_daftar"] as? String
            }
        }
    }
}



