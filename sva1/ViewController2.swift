//
//  ViewController2.swift
//  sva1
//
//  Created by scoring app code on 1/17/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    // since the controls on the page don't exist
    // before did load occur you can't pass that information
    var helloWorld:String?
    
    @IBOutlet var lblInfoDisplay: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let myHello = helloWorld {
            lblInfoDisplay.text = myHello
        }
        
    }

    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
