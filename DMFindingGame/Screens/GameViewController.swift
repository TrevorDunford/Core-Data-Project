//
//  GameViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 2/19/23.
//

import UIKit
import CoreData

class GameViewController: UIViewController {
    
    /**
     5.1 Create IBOutlets for the target letter label, the score label, and the seconds label. Also, create an IBOutlet collection for the letter buttons.
     */
    
    @IBOutlet weak var targetLetterLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    let gameBrain = GameBrain.shared
    var timer: Timer!
    /**
     6.1 Use the game brain to start a new game. Hint: We want the number of letters to be the number of letters buttons that we have.
     6.2 Create a function that uses the game brain to update the target letter label, the score label, the seconds label, and the title of each letter button. Call the function here.
     6.3 Call the provided `configureTimer` function.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        gameBrain.newGame(numLetters: letterButtons.count)
        updateUI()
        configureTimer()
        
    }
    
    
    /*
     We are invalidating the timer when the screen disappears. You do not need to modify this code.
     */
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer.invalidate()
    }
    
    /*
     You do not need to modify this code.
     */
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        updateUI()
        gameBrain.letterSelected(selectedLetter: sender.titleLabel!.text!)
       
    }
    
    func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: fireTimer(timer:))
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func updateUI() {
        targetLetterLabel.text = gameBrain.targetLetter
        scoreLabel.text = "Score: \(gameBrain.score)"
        secondsLabel.text = "Seconds: \(gameBrain.secondsRemaining)"
        
        
        for (index, button) in letterButtons.enumerated() {
            button.setTitle(gameBrain.randomLetters[index], for: .normal)
            button.backgroundColor = gameBrain.randomLetters[index] == gameBrain.targetLetter ? .systemRed : .systemBlue
        }
        
    }
    
    /**
     7.1 Use the game brain to process the selected letter and call `updateUI`.
     */
    
    /*
     8.1 This function will get called automatically every second. Uncomment the provided code and add one more line of code inside the conditional to transition the user back to the start screen.
     */
    func fireTimer(timer: Timer) {
        gameBrain.secondsRemaining -= 1
        updateUI()
        
        if gameBrain.secondsRemaining <= 0 {
            timer.invalidate()
            
            navigationController?.popToRootViewController(animated: true)
            
            
        }
    }
}
