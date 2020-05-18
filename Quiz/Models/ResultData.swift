//
//  ResultData.swift
//  Quiz
//
//  Created by Lucija Balja on 09/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation

struct ResultData: Codable {
    var quiz_id: Int
    var user_id: Int
    var time: Double
    var no_of_correct: Int
    
    init(quiz_id: Int, user_id: Int, time: Double, no_of_correct: Int) {
        self.quiz_id = quiz_id
        self.user_id = user_id
        self.time = time
        self.no_of_correct = no_of_correct
    }
}
