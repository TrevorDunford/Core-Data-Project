//
//  ScoresViewController.swift
//  DMFindingGame
//
//  Created by Trevor Dunford on 10/10/23.
//

import Foundation
import UIKit
import CoreData

class ScoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var scores: [Int] = []
    let gameBrain = GameBrain() 

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchScores()
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func fetchScores() {
        scores = CoreDataManager.shared.fetchScores()
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        cell.textLabel?.text = "\(scores[indexPath.row])"
        return cell
    }
}
