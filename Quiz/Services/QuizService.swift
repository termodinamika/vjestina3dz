//
//  QuizService.swift
//  Quiz
//
//  Created by Lucija Balja on 25/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation
import UIKit

class QuizService {
    func fetchQuizzes(completion: @escaping ((Bool, QuizResponse?) -> Void)) {
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) {
                (data,response,error) in
                if error != nil {
                    print(error ?? "Error fetching data")
                    completion(false, nil)
                    return
                }
                if let quizdata = data {
                    let decoder = JSONDecoder()
                    do {
                        let quizzes = try decoder.decode(QuizResponse.self, from: quizdata)
                        completion(true, quizzes)
                    } catch {
                        completion(false, nil)
                    }
                } else {
                    completion(false, nil)
                }
            }
            dataTask.resume()
        }
    }
    
    func sendResults(noCorrectAnswers: Int, timeTaken: Double, quizId: Int, completion: @escaping ((Int) -> Void)) {
        let urlString = "https://iosquiz.herokuapp.com/api/result"
        let userId = UserDefaults.standard.integer(forKey: "userID")
        let token = UserDefaults.standard.string(forKey: "userToken")
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "Authorization")
            
            let postData = ResultData(quiz_id: quizId, user_id: userId, time: timeTaken, no_of_correct: noCorrectAnswers)
            var encodedData = Data()
            
            do {
                encodedData = try JSONEncoder().encode(postData)
            } catch {
                print("Something is wrong with data")
            }
            
            request.httpBody = encodedData
            
            let dataTask = URLSession.shared.dataTask(with: request) {
                (data,response,error) in
                
                if error != nil {
                    print(error ?? "Error sending data")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    completion(httpResponse.statusCode)
                }
            }            
            dataTask.resume()
        }
    }
    
    func getBestScores(id: Int, completion: @escaping (Bool, [LeaderboardScore]?) -> ()){
        let urlString = "https://iosquiz.herokuapp.com/api/score?quiz_id=\(id)"
        let token = UserDefaults.standard.string(forKey: "userToken")
        print(token)
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "Authorization")
            
            let dataTask = URLSession.shared.dataTask(with: request) {
                (data,response,error) in
                
                if error != nil {
                    print(error ?? "Error sending data")
                    completion(false, nil)
                    return
                }
                
                if let returnedData = data {
                    do {
                        let decoder = JSONDecoder()
                        let leaderboardResponse = try decoder.decode([LeaderboardScore].self, from: returnedData)
                        completion(true, leaderboardResponse)
                    } catch {
                        completion(false, nil)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
