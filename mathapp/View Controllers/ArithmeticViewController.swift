//
//  ArithmeticViewController.swift
//  mathapp
//
//  Created by Aarnav Ram on 12/06/18.
//  Copyright © 2018 Aarnav Ram. All rights reserved.
//

import UIKit

class ArithmeticViewController: UIViewController {
    
    var function: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToOptions(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.unwindToOptionsFromArithmetic, sender: self)
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
