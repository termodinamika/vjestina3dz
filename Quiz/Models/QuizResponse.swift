//
//  Quiz.swift
//  Quiz
//
//  Created by Lucija Balja on 25/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation

struct QuizResponse: Decodable {
    var quizzes: [Quiz]
}

struct Quiz: Decodable {
    var category: Category
    var id: Int
    var title: String
    var description: String
    var level: Int
    var image: URL
    var questions: [Question]
}

struct Question: Decodable {
    var id: Int
    var question: String
    var answers: [String]
    var correct_answer:  Int
}


enum Category: String, Decodable, CaseIterable {
    case SPORTS, SCIENCE
}
