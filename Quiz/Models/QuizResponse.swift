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

struct Quiz: Decodable, Equatable, Hashable {
    var id: Int
    var category: Category
    var description: String
    var image: URL
    var level: Int
    var title: String
    var questions: [Question]
    
    static func == (lhs: Quiz, rhs: Quiz) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(description)
    }
}

struct Question: Decodable {
    var id: Int
    var question: String
    var answers: [String]
    var correctAnswer:  Int

    enum CodingKeys: String, CodingKey {
        case id
        case question
        case answers
        case correctAnswer = "correct_answer"
    }
}

struct CategorizedQuizzes {
    var category: Category
    var quizzes: [Quiz]
}

enum Category: String, Decodable, CaseIterable {
    case SPORTS, SCIENCE
}

extension Array where Element: Equatable {
    func uniqueElements() -> [Element] {
        var out = [Element]()
        
        for element in self {
            if !out.contains(element) {
                out.append(element)
            }
        }
        return out
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
