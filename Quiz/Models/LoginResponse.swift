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
    let user_id: Int
    let errors = ""
}
