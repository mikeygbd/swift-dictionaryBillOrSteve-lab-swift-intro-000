//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var scoreCounter: UILabel!
    @IBOutlet weak var steveButton: UIButton!
    @IBOutlet weak var billButton: UIButton!
    
    
    // Create your stored properties here
    
    var billAndSteveFacts: [String : [String]] = [:]
    var correctPerson: String = ""
    var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFacts()
        showFact()
    }
    
    func showFact() {
        let (person, fact) = getRandomFact()
        correctPerson = person
        factLabel.text = fact
    }
    
    
    func getRandomFact() -> (String, String) {
        
        let person = randomPerson()
        
        if let facts = billAndSteveFacts[person] {
            let fact = produceFact(from: facts, with: person)
            return (person, fact)
        }
        
        let otherPerson = person == "Bill Gates" ? "Steve Jobs" : "Bill Gates"
        
        if let facts = billAndSteveFacts[otherPerson] {
            let fact = produceFact(from: facts, with: otherPerson)
            return (otherPerson, fact)
        }
        
        billButton.isUserInteractionEnabled = false
        steveButton.isUserInteractionEnabled = false
        return ("", "GAME OVER")
    }
    
    func produceFact(from array: [String], with person: String) -> String {
        var copy = array
        let index = randomIndex(fromArray: copy)
        let fact = copy[index]
        copy.remove(at: index)
        billAndSteveFacts[person] = copy.isEmpty ? nil : copy
        return fact
    }
    
    func createFacts() {
        let steveFacts = [
            "He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.", "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.", "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.", "He was a pescetarian, meaning he ate no meat except for fish."
        ]
        
        let billFacts = [
            "He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.", "He scored 1590 (out of 1600) on his SATs.", "His foundation spends more on global health each year than the United Nation's World Health Organization.", "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.", "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."
        ]
        
        billAndSteveFacts["Bill Gates"] = billFacts
        
        billAndSteveFacts["Steve Jobs"] = steveFacts
    }
    


 
    @IBAction func steveGuess(_ sender: Any) {
        if correctPerson == "Steve Jobs"{
        counter += 1
        scoreCounter.text = String(counter)
        }
        showFact()
    }
    
    @IBAction func billGuess(_ sender: Any) {
        if correctPerson == "Bill Gates"{
        counter += 1
        scoreCounter.text = String(counter)
        }
        showFact()
    }
    

    // Helper Functions
    func randomIndex(fromArray array: [String]) -> Int {
        return Int(arc4random_uniform(UInt32(array.count)))
    }
    
    func randomPerson() -> String {
        let randomNumber = arc4random_uniform(2)
        
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
    
}
