//
//  LeaderboardViewController.swift
//  Quiz
//
//  Created by Lucija Balja on 17/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    let tableview = UITableView()
    let errorLabel = UILabel()
    let quizService = QuizService()
    var quizId: Int!
    var leaderboardScores: [LeaderboardScore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        setupUI()
        setupConstraints()
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
        quizService.getBestScores(id: quizId) { (response) in
            DispatchQueue.main.async {
                guard let response = response else {
                    self.errorLabel.text = "Could not fetch leaderboard scores"
                    return
                }
                self.leaderboardScores = response.count > 20 ? Array(response[0..<20]) : response
                self.tableview.reloadData()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemIndigo
        
        tableview.backgroundColor = .systemIndigo
        tableview.separatorColor = .white
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(LeaderboardCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableview)
    }
    
    private func setupConstraints() {
        tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
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
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! LeaderboardCell
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
