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
    func fetchQuizzes(completion: @escaping ((QuizResponse?) -> Void)) {
        let urlString = "\(Global.apiURL)/quizzes"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            if error != nil {
                print(error ?? "Error fetching data")
                completion(nil)
                return
            }
            guard let quizdata = data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let quizzes = try decoder.decode(QuizResponse.self, from: quizdata)
                completion(quizzes)
            } catch { completion(nil) }
        }
        dataTask.resume()
    }
    
    func sendResults(noCorrectAnswers: Int, timeTaken: Double, quizId: Int, completion: @escaping ((Int) -> Void)) {
        let urlString = "\(Global.apiURL)/result"
        let userId = UserDefaults.standard.integer(forKey: "userID")
        let token = UserDefaults.standard.string(forKey: "userToken")
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let postData = ResultData(quizID: quizId, userID: userId, time: timeTaken, noOfCorrect: noCorrectAnswers)
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
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            completion(httpResponse.statusCode)
        }
        dataTask.resume()
    }
    
    func getBestScores(id: Int, completion: @escaping ([LeaderboardScore]?) -> ()){
        let urlString = "\(Global.apiURL)/score?quiz_id=\(id)"
        let token = UserDefaults.standard.string(forKey: "userToken")
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            
            if error != nil {
                print(error ?? "Error sending data")
                completion(nil)
                return
            }
            
            guard let returnedData = data else {
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let leaderboardResponse = try decoder.decode([LeaderboardScore].self, from: returnedData)
                completion(leaderboardResponse)
            } catch {
                completion(nil)
            }
        }
        dataTask.resume()
    }
}
