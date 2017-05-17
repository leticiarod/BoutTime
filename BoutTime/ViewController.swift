//
//  ViewController.swift
//  BoutTime
//
//  Created by Leticia Rodriguez on 5/13/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let totalRounds = 6
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
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var closeWebViewButton: UIButton!
    
    var task = DispatchWorkItem(block: {()})
    
    // Counter to set the countdown timer on screen
    var counter = 60.0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make Self become first responder to respond to touch events so the actual shake can be detected
        self.becomeFirstResponder()
        // Generate tap gestures manually on event's label in order to be able to tap on an event  present a WebView
        createTapGestureOverEventsLabel()
        nextButton.isHidden = true
        nextButton.isEnabled = false
        webView.isHidden = true
        closeWebViewButton.isHidden = true
        closeWebViewButton.isEnabled = false
     //   displayEvents()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake { // if the motion is an Shake Gesture
            stopTimer()
            counter = -1
            firstEvent.isUserInteractionEnabled = true
            secondEvent.isUserInteractionEnabled = true
            thirdEvent.isUserInteractionEnabled = true
            fourthEvent.isUserInteractionEnabled = true
            checkAnswer()
        }
    }
    
    // override viewWillAppear so when final view controller is dismissed, can perform some "reset" operations on the current view before the view becomes visible
    override func viewWillAppear(_ animated: Bool) {
        nextButton.isHidden = true
        nextButton.isEnabled = false
        askedRounds = 0
        correctedRounds = 0
        displayEvents()
    }
   
    // Display 4 events on screen
    func displayEvents(){
        
        currentRound = roundProvider.randomRound()
        let round = currentRound.unorderedEvents
        
        firstEvent.text = round[0].description
        secondEvent.text = round[1].description
        thirdEvent.text = round[2].description
        fourthEvent.text = round[3].description
        nextButton.isHidden = true
        nextButton.isEnabled = false
        firstEvent.isUserInteractionEnabled = false
        secondEvent.isUserInteractionEnabled = false
        thirdEvent.isUserInteractionEnabled = false
        fourthEvent.isUserInteractionEnabled = false
        shakeToCompleteLabel.text = "Shake to complete"
        // start the timer for 60 seconds
        counter = 60
        self.timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
        
    }
    
    func checkAnswer(){
        var isCorrect = true
        var index = 0
        orderedEventsArray = Array()
        
        // Get the answers from the labels (the one that user has ordered) and store them in global orderedEventsArray var.
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
        
        // Check the answers in orderedEventsArray with the array orderedEvents which contains the correct order of the events.
        while isCorrect && index<orderedEventsArray.count {
            if orderedEventsArray[index] != currentRound.orderedEvents[index].description {
                isCorrect = false
            }
            index += 1
        }
        
        if isCorrect {
            nextButton.setBackgroundImage(UIImage(named: "next_round_success.png"), for: .normal)
            correctedRounds += 1
            nextButton.isHidden = false
            nextButton.isEnabled = true
            
        }
        else {
            nextButton.setBackgroundImage(UIImage(named: "next_round_fail.png"), for: .normal)
            nextButton.isHidden = false
            nextButton.isEnabled = true
        }
        shakeToCompleteLabel.text = "Tap events to learn more"
        
    }
    
    @IBAction func firstDownButtonPressed(_ sender: UIButton) {
        firstDownButton.setBackgroundImage(UIImage(named: "down_full_selected.png"), for: .normal)
        if let buttonId = sender.restorationIdentifier as String!{
            changeButtonColorWithDelay(buttonId: buttonId)
        }
        let secondEventAux = secondEvent.text
        secondEvent.text = firstEvent.text
        firstEvent.text = secondEventAux
    }
    
    @IBAction func secondUpButtonPressed(_ sender: UIButton) {
        secondUpButton.setBackgroundImage(UIImage(named: "up_half_selected.png"), for: .normal)
        if let buttonId = sender.restorationIdentifier as String!{
            changeButtonColorWithDelay(buttonId: buttonId)
        }
        let firstEventAux = firstEvent.text
        firstEvent.text = secondEvent.text
        secondEvent.text = firstEventAux
    }
    
    
    @IBAction func secondDownButtonPressed(_ sender: UIButton) {
        secondDownButton.setBackgroundImage(UIImage(named: "down_half_selected.png"), for: .normal)
        if let buttonId = sender.restorationIdentifier as String!{
            changeButtonColorWithDelay(buttonId: buttonId)
        }
        let secondEventAux = secondEvent.text
        secondEvent.text = thirdEvent.text
        thirdEvent.text = secondEventAux
    }
    
  
    @IBAction func thirdUpButtonPressed(_ sender: UIButton) {
        thirdUpButton.setBackgroundImage(UIImage(named: "up_half_selected.png"), for: .normal)
        if let buttonId = sender.restorationIdentifier as String!{
            changeButtonColorWithDelay(buttonId: buttonId)
        }
        let secondEventAux = secondEvent.text
        secondEvent.text = thirdEvent.text
        thirdEvent.text = secondEventAux
    }
    
    @IBAction func thirdDownButtonPressed(_ sender: UIButton) {
        thirdDownButton.setBackgroundImage(UIImage(named: "down_half_selected.png"), for: .normal)
        if let buttonId = sender.restorationIdentifier as String!{
            changeButtonColorWithDelay(buttonId: buttonId)
        }
        let thirdEventAux = thirdEvent.text
        thirdEvent.text = fourthEvent.text
        fourthEvent.text = thirdEventAux
    }
    
    @IBAction func fourthUpButtonPressed(_ sender: UIButton) {
        fourthButton.setBackgroundImage(UIImage(named: "up_full_selected.png"), for: .normal)
        if let buttonId = sender.restorationIdentifier as String!{
            changeButtonColorWithDelay(buttonId: buttonId)
        }
        let thirdEventAux = thirdEvent.text
        thirdEvent.text = fourthEvent.text
        fourthEvent.text = thirdEventAux
    }
    
    func tapFirstEvent(_ recognizer: UIGestureRecognizer) {
        closeWebViewButton.isHidden = false
        closeWebViewButton.isEnabled = true
        webView.loadRequest(URLRequest(url: URL(string: getURLByDescription(description: firstEvent.text!))!))
        webView.isHidden = false
        
    }
    
    func tapSecondEvent(_ recognizer: UIGestureRecognizer) {
        closeWebViewButton.isHidden = false
        closeWebViewButton.isEnabled = true
        webView.loadRequest(URLRequest(url: URL(string: getURLByDescription(description: secondEvent.text!))!))
        webView.isHidden = false
    }
    
    func tapThirdEvent(_ recognizer: UIGestureRecognizer) {
        closeWebViewButton.isHidden = false
        closeWebViewButton.isEnabled = true
        webView.loadRequest(URLRequest(url: URL(string: getURLByDescription(description: thirdEvent.text!))!))
        webView.isHidden = false
    }
    
    func tapFourthEvent(_ recognizer: UIGestureRecognizer) {
        closeWebViewButton.isHidden = false
        closeWebViewButton.isEnabled = true
        webView.loadRequest(URLRequest(url: URL(string: getURLByDescription(description: fourthEvent.text!))!))
        webView.isHidden = false
    }

    
    @IBAction func closeWebViewButtonPressed(_ sender: UIButton) {
        webView.isHidden = true
        closeWebViewButton.isHidden = true
        closeWebViewButton.isEnabled = false
    }
    
    @IBAction func nextRoundButton(_ sender: UIButton) {
        askedRounds += 1
        if askedRounds == totalRounds { //Round is over
            
            // Find the view controller in the storyboard
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //Wrap your view controller within the navigation controller
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView")
            
            self.performSegue(withIdentifier: "finishGame", sender: self)
            //Present the navigation controller
            self.present(nextViewController, animated:true, completion:nil)
        } else {
            // Continue game
            displayEvents()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishGame" {
            guard let finalViewController = segue.destination as? FinalViewController else {
                return
            }
            finalViewController.correctedRounds = self.correctedRounds
            finalViewController.totalRounds = self.totalRounds
        }
    }

    // MARK: - Helper Methods
    
    func changeButtonColorWithDelay(buttonId: String) {
        // A DispatchWorkItem task is created and assigned it into a global var to be able to run it as well as cancel it (from any part in the code)  if necessary.
        task = DispatchWorkItem(block: {self.changeButtonBackgroundColor(buttonId: buttonId)})

        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: task)
    }
    
    //
    func timeLabelFormat(seconds: Int){
        switch seconds{
        case 60: self.timeLabel.text = "1:00"
        case 10...59: self.timeLabel.text = "00:\(seconds)"
        case 1...9: self.timeLabel.text = "00:0\(seconds)"
        default: return
        }
    }
    
    // Method to change the color of
    func changeButtonBackgroundColor(buttonId: String) {
        switch buttonId{
        case "firstDownButton": self.firstDownButton.setBackgroundImage(UIImage(named: "down_full.png"), for: .normal)
        case "secondUpButton": self.secondUpButton.setBackgroundImage(UIImage(named: "up_half.png"), for: .normal)
        case "secondDownButton": self.secondDownButton.setBackgroundImage(UIImage(named: "down_half.png"), for: .normal)
        case "thirdUpButton":self.thirdUpButton.setBackgroundImage(UIImage(named: "up_half.png"), for: .normal)
        case "thirdDownButton":self.thirdDownButton.setBackgroundImage(UIImage(named: "down_half.png"), for: .normal)
        case "fourthButton":self.fourthButton.setBackgroundImage(UIImage(named: "up_full.png"), for: .normal)
        default: return
        }
    }
    
    
    func getURLByDescription(description: String) -> String{
        var founded = false
        var i = 0
        var url = ""
        while !founded && i < currentRound.orderedEvents.count {
            if currentRound.orderedEvents[i].description == description {
                founded = true
                url = currentRound.orderedEvents[i].url
            }
            i += 1
        }
        return url
    }
    
    
    
    // MARK: - Timer Methods
    
    func stopTimer(){
        timer.invalidate()
    }
    
    // update counter for Timer
    func updateCounter() {
        if counter >= -1{
            counter-=0.5
            timeLabelFormat(seconds: Int(counter))
            // timeLabel.text = String(describing: counter)
        }
        else {
            stopTimer()
            counter = 0
            timeLabel.text = "00:00"
            firstEvent.isUserInteractionEnabled = true
            secondEvent.isUserInteractionEnabled = true
            thirdEvent.isUserInteractionEnabled = true
            fourthEvent.isUserInteractionEnabled = true
            checkAnswer()
        }
    }
    
    // MARK: - Tap Gestures created programaticlly
    
    func createTapGestureOverEventsLabel(){
        //
        let tapFirstEvent = UITapGestureRecognizer(target: self, action: #selector(self.tapFirstEvent(_:)))
        firstEvent.addGestureRecognizer(tapFirstEvent)
        let tapSecondEvent = UITapGestureRecognizer(target: self, action: #selector(self.tapSecondEvent(_:)))
        secondEvent.addGestureRecognizer(tapSecondEvent)
        let tapThirdEvent = UITapGestureRecognizer(target: self, action: #selector(self.tapThirdEvent(_:)))
        thirdEvent.addGestureRecognizer(tapThirdEvent)
        let tapFourthEvent = UITapGestureRecognizer(target: self, action: #selector(self.tapFourthEvent(_:)))
        fourthEvent.addGestureRecognizer(tapFourthEvent)

    }


}
 


