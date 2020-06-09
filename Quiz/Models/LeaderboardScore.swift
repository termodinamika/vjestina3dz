//
//  LeaderboardResponse.swift
//  Quiz
//
//  Created by Lucija Balja on 17/05/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation

struct LeaderboardScore: Decodable {
    var username: String
    var score: String?
}
