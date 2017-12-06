//
//  KelasTableViewController.swift
//  DataSiswaIDNApps
//
//  Created by muqorrobin aimar on 11/20/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class KelasTableViewController: UITableViewController {
    
    var IdSelected:String?
    var namaSelected:String?
    var jumlahSelected:String?
    
    
    var siswa = [Siswa]()
    var arrKar = [[String: AnyObject]]()//array data siswa

    override func viewDidLoad() {
        super.viewDidLoad()
        //memanggil data json menggunakan alamofire
        Alamofire.request("http://localhost/DataSiswaServer/index.php/Api/getKelas").responseJSON { (responseData) -> Void in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! KelasTableViewCell
        
        // Configure the cell...
        var dict = arrKar[indexPath.row]
        cell.jumlah.text = dict["jumlah_siswa"] as? String
        cell.kelas.text = dict["nama_kelas"] as? String
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        print("Row \(indexPath.row)selected")
        
        let task = arrKar[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        jumlahSelected = task["jumlah_siswa"] as? String
        namaSelected = task["nama_kelas"] as? String
        IdSelected = task["id_kelas"] as? String
        
        
        
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
                let controller = segue.destination as! KDetailViewController
                let value = arrKar[indexPath.row]
                
                controller.passJumlah = value["jumlah_siswa"] as? String
                controller.passKelas = value["nama_kelas"] as? String
                controller.passID = value["id_kelas"] as? String
                
            }
        }
    }
}








