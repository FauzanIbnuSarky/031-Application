//
//  RSiswaViewController.swift
//  DataSiswaIDNApps
//
//  Created by muqorrobin aimar on 11/20/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RSiswaViewController: UIViewController {
    @IBOutlet weak var etSiswa: UITextField!
    @IBOutlet weak var etNama: UITextField!
    @IBOutlet weak var etKelas: UITextField!
    @IBOutlet weak var etAlamat: UITextField!
    
    @IBOutlet weak var etKelamin: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBAction func btnSave(_ sender: Any) {
        let nilaiSiswa = etSiswa.text!
        let nilaiNama = etNama.text!
        let nilaiKelas = etKelas.text!
        let nilaiAlamat = etAlamat.text!
        let nilaiKelamin = etKelamin.text!
        
        if ((nilaiNama.isEmpty) || (nilaiKelas.isEmpty) || (nilaiSiswa.isEmpty) || (nilaiAlamat.isEmpty) || (nilaiKelamin.isEmpty)){
            
            //muncul alert dialog
            let alertWarning = UIAlertController(title: "Warning", message: "This is required", preferredStyle: .alert)
            let aksi = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertWarning.addAction(aksi)
            present(alertWarning, animated: true, completion: nil)
        }else{
            //apabila widget tidak kosong
            //membuat parameter untuk di simpan ke database
            let params = ["id_siswa" : nilaiSiswa,
                          "nama_siswa" : nilaiNama,
                          "alamat" : nilaiAlamat,
                          "id_kelas" : nilaiKelas,
                          "jenis_kelamin" : nilaiKelamin]
            //mencetak nilai params yang dikirim
            print(params)
            
            let url  = "http://localhost/DataSiswaServer/index.php/Api/daftarSiswa"
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseServer) in
                
                print(responseServer.result.isSuccess)
                
                if responseServer.result.isSuccess{
                    let json = JSON(responseServer.result.value as Any)
                    //muncul alert dialog
                    let alertWarning = UIAlertController(title: "Congrats", message: "Data berhasil disimpan", preferredStyle: .alert)
                    let aksi = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertWarning.addAction(aksi)
                    self.present(alertWarning, animated: true, completion: nil)
                    
                }
                
            })
        }
    }
}
