//
//  ServerResponse.swift
//  Quiz
//
//  Created by Lucija Balja on 09/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation

enum ServerResponse: Int {
    case UNAUTHORIZED = 401
    case FORBIDDEN = 403
    case NOT_FOUND = 404
    case BAD_REQUEST = 400
    case SUCCESS = 200
}
