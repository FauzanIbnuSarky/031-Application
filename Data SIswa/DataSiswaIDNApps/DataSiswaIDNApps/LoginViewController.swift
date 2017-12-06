//
//  LoginViewController.swift
//  DataSiswaIDNApps
//
//  Created by Rizki Syaputra on 11/16/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var etUsername: UITextField!
    
    //deklarasi userDefault untuk menampung data agar tetap login
    var userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userDefaults = UserDefaults.standard
    }

    @IBAction func btnLogin(_ sender: Any) {
        let nilaiUser = etUsername.text!
        let nilaiPass = etPassword.text!
        
        if ((nilaiUser.isEmpty) || (nilaiPass.isEmpty)) {
            //muncul alert dialog
            let alertWarning = UIAlertController(title: "Warning", message: "This is required", preferredStyle: .alert)
            let aksi = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertWarning.addAction(aksi)
            present(alertWarning, animated: true, completion: nil)
            
        }  else if  ((nilaiUser.isEmpty) || (nilaiPass.isEmpty)) {
            //muncul alert dialog
            let alertWarning = UIAlertController(title: "Warning", message: "This is required", preferredStyle: .alert)
            let aksi = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertWarning.addAction(aksi)
            present(alertWarning, animated: true, completion: nil)
        } else {
            let params = ["email" : nilaiUser, "password" : nilaiPass]
            print(params)
            let url  = "http://localhost/DataSiswaServer/index.php/Api/login"
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseServer) in
                
                print(responseServer.result.isSuccess)
                
                if responseServer.result.isSuccess{
                    let json = JSON(responseServer.result.value as Any)
                    
                    print(json)
                    let data = json["data"].dictionaryValue
                    let nUsername = data["username"]?.stringValue
                    let nEmail = data["password"]?.stringValue
                    
                    //menyimpan data ke sesi lokal
                    
                    self.userDefaults.setValue(nUsername, forKey: "USERNAME")
                    self.userDefaults.setValue(nEmail, forKey: "PASSWORD")
                    //untuk sinkronisasi data
                    self.userDefaults.synchronize()
                   
                    //pindah ke layout welcome
                    let story = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                    let id = story.instantiateViewController(withIdentifier: "userLayout")
                    self.show(id, sender: self)
                }
            })
        }
    }
}
