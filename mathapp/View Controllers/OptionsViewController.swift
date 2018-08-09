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
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //debug button purposes to just move to next screen
    @IBAction func OnNextPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SegueIdentifier.multiply, sender: self)
    }
    
    
    //depending on the button send the right info to the next VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case SegueIdentifier.add:
            if let destination = segue.destination as? ArithmeticViewController {
                destination.function = Function.add
            }
        case SegueIdentifier.multiply:
            if let destination = segue.destination as? ArithmeticViewController {
                destination.function = Function.multiply
            }
        case SegueIdentifier.subtract:
            if let destination = segue.destination as? ArithmeticViewController {
                destination.function = Function.subtract
            }
        case SegueIdentifier.random:
            if let destination = segue.destination as? ArithmeticViewController {
                destination.function = Function.random
            }
        default:
            if let destination = segue.destination as? ArithmeticViewController {
                destination.function = Function.random
            }
        }
    }

}
