//
//  ViewController.swift
//  BoutTime
//
//  Created by Leticia Rodriguez on 5/13/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let totalRounds = 1
    var askedRounds = 0
    var correctedRounds = 0
    
    var orderedEventsArray: [String] = Array()
    
    let roundProvider = RoundProvider()
    var currentRound = Round()
    
    @IBOutlet weak var firstEvent: UILabel!
    @IBOutlet weak var secondEvent: UILabel!
    @IBOutlet weak var thirdEvent: UILabel!
    @IBOutlet weak var fourthEvent: UILabel!
    @IBOutlet weak var firstDownButton: UIButton!
    @IBOutlet weak var secondUpButton: UIButton!
    @IBOutlet weak var secondDownButton: UIButton!
    @IBOutlet weak var thirdUpButton: UIButton!
    @IBOutlet weak var thirdDownButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var shakeToCompleteLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var task = DispatchWorkItem(block: {()})
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("pase por view did load ")
        self.becomeFirstResponder()
        nextButton.isHidden = true
        nextButton.isEnabled = false
        displayEvents()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            checkAnswer()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("estoy en will appear ")
        nextButton.isHidden = true
        nextButton.isEnabled = false
        askedRounds = 0
        correctedRounds = 0
        displayEvents()
    }
   
    func displayEvents(){
        
        currentRound = roundProvider.randomRound()
        let round = currentRound.unorderedEvents
        
        firstEvent.text = round[0].description
        secondEvent.text = round[1].description
        thirdEvent.text = round[2].description
        fourthEvent.text = round[3].description
        nextButton.isHidden = true
        nextButton.isEnabled = false
        // invoco a un timer de 60 segundos
    }
    
    func checkAnswer(){
        print("estoy en check answer")
        var isCorrect = true
        var index = 0
        orderedEventsArray = Array()
        
        // obtengo las respuestas de las labels y las almaceno en el array ordered events
        if let text = firstEvent.text as String! {
            orderedEventsArray.append(text)
        }
        if let text = secondEvent?.text as String!  {
            orderedEventsArray.append(text)
        }
        if let text = thirdEvent?.text as String! {
            orderedEventsArray.append(text)
        }
        if let text = fourthEvent?.text as String!{
            orderedEventsArray.append(text)
        }
        
        print("currentRound.orderedEvents[index] \(currentRound.orderedEvents)")
        
        // comparo las respues del array anterior con las reales
        while isCorrect && index<orderedEventsArray.count {
            print("estoy en el while index: \(index)")
            if orderedEventsArray[index] != currentRound.orderedEvents[index].description {
                isCorrect = false
            }
            index += 1
        }
        
        if isCorrect {
            print("estoy en el if")
            nextButton.setBackgroundImage(UIImage(named: "next_round_success.png"), for: .normal)
            correctedRounds += 1
            nextButton.isHidden = false
            nextButton.isEnabled = true
        }
        else {
            print("esto en el else ")
            nextButton.setBackgroundImage(UIImage(named: "next_round_fail.png"), for: .normal)
            nextButton.isHidden = false
            nextButton.isEnabled = true
        }
        
        
    }
    
    func displayScore(){
        
    }
    
    @IBAction func firstDownButtonPressed(_ sender: UIButton) {
        
        firstDownButton.setBackgroundImage(UIImage(named: "down_full_selected.png"), for: .normal)
        changeButtonColorWithDelay(seconds: 1)
        let secondEventAux = secondEvent.text
        secondEvent.text = firstEvent.text
        firstEvent.text = secondEventAux
    }
    
    
   
    @IBAction func test(_ sender: UIButton) {
         }
    
    @IBAction func secondUpButtonPressed(_ sender: UIButton) {
        secondUpButton.setBackgroundImage(UIImage(named: "up_half_selected.png"), for: .normal)
        let firstEventAux = firstEvent.text
        firstEvent.text = secondEvent.text
        secondEvent.text = firstEventAux
    }
    
    
    @IBAction func secondDownButtonPressed(_ sender: UIButton) {
        let secondEventAux = secondEvent.text
        secondEvent.text = thirdEvent.text
        thirdEvent.text = secondEventAux
    }
    
  
    @IBAction func thirdUpButtonPressed(_ sender: UIButton) {
        let secondEventAux = secondEvent.text
        secondEvent.text = thirdEvent.text
        thirdEvent.text = secondEventAux
    }
    
    @IBAction func thirdDownButtonPressed(_ sender: UIButton) {
        let thirdEventAux = thirdEvent.text
        thirdEvent.text = fourthEvent.text
        fourthEvent.text = thirdEventAux
    }
    
    
    @IBAction func fourthUpButtonPressed(_ sender: UIButton) {
        let thirdEventAux = thirdEvent.text
        thirdEvent.text = fourthEvent.text
        fourthEvent.text = thirdEventAux
    }
    
    @IBAction func nextRoundButton(_ sender: UIButton) {
        print("presione next button y askedRounds es igual a \(askedRounds)")
        askedRounds += 1
        if askedRounds == totalRounds {
            print("entre a askedRounds == totalRounds \(askedRounds) \(totalRounds)")
         
            // Find the view controller in the storyboard
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //Wrap your view controller within the navigation controller
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView")
            //Present the navigation controller
            //nextViewController. stringPassed = "\(correctedRounds)/\(totalRounds)"
            self.performSegue(withIdentifier: "finishGame", sender: self)
            
            self.present(nextViewController, animated:true, completion:nil)
            
            //  task.cancel()
            // Game is over
            //displayScore()
        } else {
            // Continue game
            print("estoy en el else ")
            displayEvents()
        }

        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishGame" {
            guard let finalViewController = segue.destination as? FinalViewController else {
                return
            }
            
            finalViewController.correctedRounds = correctedRounds
        }
    }

    // MARK: - Helper Methods
    
    func changeButtonColorWithDelay(seconds: Double) {
        // A DispatchWorkItem task is created and assigned it into a global var to be able to run it as well as cancel it (from any part in the code)  if necessary.
        task = DispatchWorkItem(block: {self.firstDownButton.setBackgroundImage(UIImage(named: "down_full.png"), for: .normal)})
        
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: task)
        
    }
    
    // cambiar nombre de funcion 
    func disableButtonsWithDelay(seconds: Int) {
        // A DispatchWorkItem task is created and assigned it into a global var to be able to run it as well as cancel it (from any part in the code)  if necessary.
        task = DispatchWorkItem(block: {})
        
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: task)
        
    }



}
 


