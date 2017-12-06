//
//  KDetailViewController.swift
//  DataSiswaIDNApps
//
//  Created by muqorrobin aimar on 11/20/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit

class KDetailViewController: UIViewController {
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var jumlah: UILabel!
    @IBOutlet weak var kelas: UILabel!
    
    
    var passID:String?
    var passJumlah:String?
    var passKelas:String?
    
    
    
    override func viewDidLoad() {
        id.text = passID!
        jumlah.text = passJumlah!
        kelas.text = passKelas!
      
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


