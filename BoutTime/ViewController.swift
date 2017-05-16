//
//  ViewController.swift
//  BoutTime
//
//  Created by Leticia Rodriguez on 5/13/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

let roundProvider = RoundProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pressbutton(_ sender: Any) {
        let r = roundProvider.randomRound()
        
        print(r.unorderedEvents)
        print(r.orderedEvents)
        
    }
}

