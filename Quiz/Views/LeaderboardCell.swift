//
//  LeaderboardCell.swift
//  Quiz
//
//  Created by Lucija Balja on 17/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "AvenirNext-Bold", size: 26.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        addSubview(cellView)
        cellView.addSubview(positionLabel)
        cellView.addSubview(usernameLabel)
        cellView.addSubview(pointsLabel)
        self.selectionStyle = .none
    }
    
    func setupConstraints() {
        cellView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cellView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        positionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        positionLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        positionLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        positionLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        
        usernameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: positionLabel.rightAnchor, constant: 10).isActive = true
        
        pointsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pointsLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        pointsLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        pointsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        
    }
}
