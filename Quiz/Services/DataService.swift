//
//  DataService.swift
//  Quiz
//
//  Created by Lucija Balja on 09/06/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation

class DataService {
    
    static func saveUserParams(username: String, token: String, userID: Int) {
        UserDefaults.standard.set(token, forKey: "userToken")
        UserDefaults.standard.set(userID, forKey: "userID")
        UserDefaults.standard.set(username, forKey: "username")
    }
    
    static func removeUserParams(for keys: [String]){
        for key in keys {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
}
