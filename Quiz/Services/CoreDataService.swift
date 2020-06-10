//
//  DataPersistanceService.swift
//  Quiz
//
//  Created by Lucija Balja on 04/06/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataService {
    let context = ((UIApplication).shared.delegate as! AppDelegate).persistentContainer.viewContext
    var quizData: [QuizData] = []
    
    func prepareData(quiz: Quiz) {
        let data = QuizData(context: self.context)
        data.id = Int16(quiz.id)
        data.category = quiz.category.rawValue
        data.title = quiz.title
        data.level = Int16(quiz.level)
        data.quizDescription = quiz.description
        data.image = quiz.image
        data.quizQuestions = NSSet()
        for question in quiz.questions {
            let questionData = QuestionData(context: context)
            questionData.id = Int16(question.id)
            questionData.correctAnswer = Int16(question.correctAnswer)
            questionData.question = question.question
            questionData.answers = question.answers
            questionData.parentQuiz = data
            data.quizQuestions?.adding(questionData)
        }
        quizData.append(data)
        saveQuizzes()
    }
    
    func saveQuizzes(){
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
    }
    
    func loadQuizzes(with searchWord: String = "", completion: @escaping ([QuizData]?) -> ()){
        let request: NSFetchRequest<QuizData> = QuizData.fetchRequest()
        if !searchWord.isEmpty {
            let titlePredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchWord)
            let descriptionPredicate = NSPredicate(format: "quizDescription CONTAINS[cd] %@", searchWord)
            request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [titlePredicate, descriptionPredicate])
        }
 
        do {
            quizData = try context.fetch(request)
            quizData.count != 0 ? completion(quizData) : completion(nil)
        } catch {
            completion(nil)
            print("Error fetching data via search bar, \(error)")
        }
    }
    
    func convertQuizData(_ quizData: [QuizData]) -> [Quiz] {
        var convertedQuizzes: [Quiz] = []
        for quizEntity in quizData {
            var questions: [Question] = []
            for questionEntity in quizEntity.quizQuestions?.allObjects as! [QuestionData] {
                let questionText = questionEntity.question ?? "Default question"
                let answers = questionEntity.answers ?? []
                let question = Question(id: Int(questionEntity.id),question: questionText, answers: answers, correctAnswer: Int(questionEntity.correctAnswer))
                questions.append(question)
            }
            let title = quizEntity.title ?? "default title"
            let category = Category(rawValue: quizEntity.category ?? "SPORTS") ?? Category.SPORTS
            let description = quizEntity.quizDescription ?? "default description"
            let image  = quizEntity.image!
            let quiz = Quiz(id: Int(quizEntity.id), category: category, description: description, image: image, level: Int(quizEntity.level), title: title, questions: questions)
            convertedQuizzes.append(quiz)
        }
        return convertedQuizzes
    }
}
