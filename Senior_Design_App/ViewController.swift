//
//  ViewController.swift
//  Senior_Design_App
//
//  Created by Zifan Wang on 4/19/18.
//  Copyright © 2018 Zifan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Action to room list panel
    @IBAction func To_Room_List(_ sender: Any) {
        performSegue(withIdentifier: "segue_to_room_list", sender: self)
    }
    
    // Display the installation guide
    let pdf = "Installation Guide"
    @IBAction func To_Installatio_Guide(_ sender: Any) {
        if let url = Bundle.main.url(forResource: pdf, withExtension: "pdf") {
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest as URLRequest)
            //self.view.addSubview(webView)
            let pdfVC = UIViewController()
            pdfVC.view.addSubview(webView)
            pdfVC.title = pdf
            self.navigationController?.pushViewController(pdfVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

