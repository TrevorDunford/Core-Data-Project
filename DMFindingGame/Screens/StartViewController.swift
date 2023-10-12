//
//  StartViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/17/23.
//

import UIKit
import CoreData
/**
 1.1 Create the user interface. The app will have two screens: the start screen and the game screen. The start screen will be controlled by the `StartViewController`, and the game screes will be controlled by the `GameViewController`.  See the provided screenshots and video for how the UI should look. Feel free to customize the colors, font, etc.
 1.2 Create an IBOutlet for the high score label.
 */
class StartViewController: UIViewController {
    
    
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var gameBrain = GameBrain.shared
    var coreDataManager = CoreDataManager.shared
    /**
     3.1 Update the `highScoreLabel`'s text to be the high score from the game brain.
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let savedScore = gameBrain.score
        if savedScore > 0 {
            coreDataManager.addScore(score: savedScore)
        }
        highScoreLabel.text = "High Score: \(coreDataManager.calculateHighScore())"
    }
    
    /**
     4.1 Transition the user to the `GameViewController`.
     */
    @IBAction func goToNextScreenButtonTapped(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameVC = storyboard.instantiateViewController(withIdentifier: "GameViewController")
            self.navigationController?.pushViewController(gameVC, animated: true)
        }
    
    @IBAction func scoresScreen (sender: UIButton ) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let scoresVC = storyboard.instantiateViewController(withIdentifier: "ScoresViewController")
        present(scoresVC, animated: true)
    }
}

