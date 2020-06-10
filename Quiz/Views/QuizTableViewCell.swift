//
//  QuizTableViewCell.swift
//  Quiz
//
//  Created by Lucija Balja on 29/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizTitle: UILabel!
    @IBOutlet weak var quizDescription: UILabel!
    @IBOutlet weak var level1Image: UIImageView!
    @IBOutlet weak var level2Image: UIImageView!
    @IBOutlet weak var level3Image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        layer.cornerRadius = 30
        layer.masksToBounds = true
        selectionStyle = .none

    }
    
    func setLevelImage(level: Int, color: UIColor) {
        switch level {
        case 1:
            level1Image.tintColor = color
        case 2:
            level1Image.tintColor = color
            level2Image.tintColor = color
        case 3:
            level1Image.tintColor = color
            level2Image.tintColor = color
            level3Image.tintColor = color
        default:
            level1Image.tintColor = .systemGray
            level2Image.tintColor = .systemGray
            level3Image.tintColor = .systemGray
        }
    }
}
