//
//  Utils.swift
//  Quiz
//
//  Created by Lucija Balja on 05/06/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation

class Utils {
    
    static func categorySorting(_ quizzes: [Quiz]) -> [Category: [Quiz]] {
        var sortedData = [Category: [Quiz]]()
        for category in Category.allCases {
            sortedData[category] = quizzes.filter({ (quiz) in
                return quiz.category == category
            })
        }
        return sortedData
    }
}
