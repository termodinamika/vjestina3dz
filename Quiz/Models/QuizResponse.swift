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

class Quiz: Decodable, Equatable, Hashable {
    var category: Category
    var id: Int
    var title: String
    var description: String
    var level: Int
    var image: URL
    var questions: [Question]
    
    init(id: Int,title: String,description: String,level: Int,image: URL,questions: [Question],category: Category) {
        self.category = category
        self.id = id
        self.description = description
        self.title = title
        self.level = level
        self.image = image
        self.questions = questions
    }
    
    static func == (lhs: Quiz, rhs: Quiz) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(description)
    }
}

class Question: Decodable {
    var id: Int
    var question: String
    var answers: [String]
    var correct_answer:  Int
    
    init(id: Int,question: String,answers: [String],correct_answer:  Int) {
        self.id = id
        self.question = question
        self.answers = answers
        self.correct_answer = correct_answer
    }
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
