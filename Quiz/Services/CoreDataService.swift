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
            questionData.correctAnswer = Int16(question.correct_answer)
            questionData.question = question.question
            questionData.answers = question.answers
            questionData.parentQuiz = data
            data.quizQuestions?.adding(questionData)
        }
        quizData.append(data)
        saveQuizzes()
       // checkIfEntityExists(with: data.id)
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
            if(quizData.count != 0) {
                completion(quizData)
            } else {
                completion(nil)
            }
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
                let question = Question(id: Int(questionEntity.id), question: questionEntity.question ?? "Default question", answers: questionEntity.answers ?? [], correct_answer:  Int(questionEntity.correctAnswer))
                questions.append(question)
            }
            let quiz = Quiz(id: Int(quizEntity.id),title: quizEntity.title ?? "default title",description: quizEntity.quizDescription ?? "default description",level: Int(quizEntity.level),image: quizEntity.image!, questions: questions, category: Category(rawValue: quizEntity.category ?? "SPORTS") ?? Category.SPORTS)
            convertedQuizzes.append(quiz)
        }
        return convertedQuizzes
    }
}
