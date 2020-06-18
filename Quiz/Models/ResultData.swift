//
//  ResultData.swift
//  Quiz
//
//  Created by Lucija Balja on 09/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation

struct ResultData: Decodable, Encodable {
    var quizID: Int
    var userID: Int
    var time: Double
    var noOfCorrect: Int
    
    enum CodingKeys: String, CodingKey {
         case quizID = "quiz_id"
         case userID = "user_id"
         case time
         case noOfCorrect = "no_of_correct"
     }
}

