//
//  SWViewControllerTwo.swift
//  Senior_Design_App
//
//  Created by Zifan Wang on 4/20/18.
//  Copyright © 2018 Zifan Wang. All rights reserved.
//

import UIKit

class SWViewControllerTwo: UIViewController {

    @IBOutlet weak var Open: UIBarButtonItem!
    
    @IBAction func Back(_ sender: Any) {
        performSegue(withIdentifier: "show_room_list_two", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Call the slideOutMenus action
        slideOutMenus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // slide out menus display
    private func slideOutMenus() {
        if revealViewController() != nil {
            // define open buttom as a revealViewController
            Open.target = revealViewController()
            // Define the open action
            Open.action = #selector(SWRevealViewController.revealToggle(_:))
            // Set the Width of revealViewController
            revealViewController().rearViewRevealWidth = 250
            // Enable the slide out action
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
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
