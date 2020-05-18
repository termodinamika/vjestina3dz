//
//  LeaderboardService.swift
//  Quiz
//
//  Created by Lucija Balja on 17/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation

class LeaderboardService {
    
    func getBestScores(id: Int, completion: @escaping (Bool, [LeaderboardScore]?) -> ()){
        let urlString = "https://iosquiz.herokuapp.com/api/score?quiz_id=\(id)"
        let token = UserDefaults.standard.string(forKey: "userToken")
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
