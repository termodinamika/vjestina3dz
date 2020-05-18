//
//  LoginService.swift
//  Quiz
//
//  Created by Lucija Balja on 28/04/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation

class LoginService {
    
    func loginUser(username: String, password: String, completion: @escaping (Bool, LoginResponse?) -> ()) {
        let apiURL = "https://iosquiz.herokuapp.com/api/session?"
        if let url = URL(string: apiURL) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let postData = "username=\(username)&password=\(password)"
            request.httpBody = postData.data(using: String.Encoding.utf8)
                 
             let dataTask = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if let error = error {
                    completion(false, nil)
                    print(error.localizedDescription)
                    return
                }
                if let returnedData = data {
                    do {
                        let decoder = JSONDecoder()
                        let serverResponse = try decoder.decode(LoginResponse.self, from: returnedData)
                        if serverResponse.errors != ""  {
                            completion(false, serverResponse)
                        } else {
                            completion(true, serverResponse)
                        }
                    } catch {
                        completion(false, nil)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
