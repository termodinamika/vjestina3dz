//
//  LeaderboardViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 17/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    let leaderboardView = LeaderboardView()
    let quizService = QuizService()
    var quizId: Int!
    var leaderboardScores: [LeaderboardScore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardView.tableview.delegate = self
        leaderboardView.tableview.dataSource = self
        setupUI()
        setupConstraints()
        setupEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func setQuizId(id: Int) {
        self.quizId = id
        fetchLeaderboardData()
    }
    
    func setupEvents() {
        leaderboardView.dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
    }
    
    @objc func dismissPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchLeaderboardData() {
        quizService.getBestScores(id: quizId) { (response) in
            DispatchQueue.main.async {
                guard let response = response else {
                    self.leaderboardView.setErrorLabel()
                    return
                }
                for leaderboardScore in response {
                    if self.leaderboardScores.count < 20 && leaderboardScore.score != nil {
                        self.leaderboardScores.append(leaderboardScore)
                    }
                }
                self.leaderboardView.tableview.reloadData()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemIndigo
        leaderboardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leaderboardView)
    }
    
    private func setupConstraints() {
        leaderboardView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leaderboardView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        leaderboardView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        leaderboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
}

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardScores.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let playerLabel = UILabel()
        Setup.setLabel(playerLabel, text: "Player")
        
        let pointsLabel = UILabel()
        Setup.setLabel(pointsLabel, text: "Points")
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .systemIndigo
        headerView.addSubview(playerLabel)
        headerView.addSubview(pointsLabel)
        
        playerLabel.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        playerLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20).isActive = true
        playerLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        pointsLabel.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        pointsLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        pointsLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaderboardView.tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! LeaderboardCell
        let data = leaderboardScores[indexPath.row]
        cell.positionLabel.text = "\(indexPath.row + 1)."
        cell.usernameLabel.text = data.username
        cell.pointsLabel.text = String(data.score?.split(separator: ".")[0] ?? "0")
        return cell
    }
}

extension LeaderboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
