//
//  LoginResponse.swift
//  Quiz
//
//  Created by Lucija Balja on 07/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation

struct LoginResponse: Decodable {
    let token: String
    let userID: Int
    let errors = ""
    
    enum CodingKeys: String, CodingKey {
        case token
        case userID = "user_id"
        case errors
    }
}
