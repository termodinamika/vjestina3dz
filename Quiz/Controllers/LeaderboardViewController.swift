//
//  LeaderboardViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 17/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemIndigo
        tv.separatorColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let errorLabel = UILabel()
    let leaderboardService = LeaderboardService()
    var quizId: Int!
    var leaderboardScores: [LeaderboardScore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        setupTableView()
    }
    func setupTableView() {
        view.backgroundColor = .systemIndigo
        tableview.register(LeaderboardCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Leaderboard"
    
        self.navigationItem.setHidesBackButton(true, animated: true);
        self.navigationController?.navigationBar.isTranslucent = false
        
        let barButtonItemRight = UIBarButtonItem(title:"X", style: .plain, target: self, action: #selector(quitLeaderboard))
        self.navigationItem.rightBarButtonItem = barButtonItemRight
    }
    
    @objc func quitLeaderboard() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setQuizId(id: Int) {
        self.quizId = id
        fetchLeaderboardData()
    }
    
    func fetchLeaderboardData() {
        leaderboardService.getBestScores(id: quizId) { (status, response) in
            if status {
                DispatchQueue.main.async {
                    self.leaderboardScores = response!
                    self.leaderboardScores =  Array(self.leaderboardScores[0..<20])
                    self.tableview.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.errorLabel.text = "error happend"
                }
            }
        }
    }
}

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardScores.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let playerLabel = UILabel()
        playerLabel.textColor = .white
        playerLabel.font = .boldSystemFont(ofSize: 20.0)
        playerLabel.text = "Player"
        playerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let pointsLabel = UILabel()
        pointsLabel.textColor = .white
        pointsLabel.font = .boldSystemFont(ofSize: 20.0)
        pointsLabel.text = "Points"
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false

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
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! LeaderboardCell
        let data = leaderboardScores[indexPath.row]
        cell.positionLabel.text = "\(indexPath.row + 1)."
        cell.usernameLabel.text = data.username
        cell.pointsLabel.text = String(data.score.split(separator: ".")[0])
        return cell
    }
}

extension LeaderboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
