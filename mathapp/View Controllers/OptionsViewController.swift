//
//  OptionsViewController.swift
//  mathapp
//
//  Created by Aarnav Ram on 12/06/18.
//  Copyright © 2018 Aarnav Ram. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnNextPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SegueIdentifier.multiply, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        if identifier == SegueIdentifier.multiply {
            if let destination = segue.destination as? ArithmeticViewController {
                destination.function = Function.multiply
            }
        }
        
    }

}

extension OptionsViewController {
    @IBAction func unwindFromArithmeticVC(segue: UIStoryboardSegue) {
        //just to unwind as it is good style
    }
}
