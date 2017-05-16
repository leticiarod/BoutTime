//
//  FinalViewController.swift
//  BoutTime
//
//  Created by Leticia Rodriguez on 5/16/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    var correctedRounds: Int = 0
    
    @IBOutlet weak var playAgayButton: UIButton!
    
    @IBOutlet weak var finalScoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("estoy en el view did load de final view correctedRounds \(correctedRounds)")
        finalScoreLabel.text = "\(correctedRounds)/6"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
