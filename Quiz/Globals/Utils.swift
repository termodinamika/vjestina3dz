//
//  Utils.swift
//  Quiz
//
//  Created by Lucija Balja on 05/06/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    static func categorySorting(_ quizzes: [Quiz]) -> [CategorizedQuizzes] {
        var sortedData = [CategorizedQuizzes]()
        for category in Category.allCases {
            let quizzes = quizzes.filter({ (quiz) in
                return quiz.category == category
            })
            if(quizzes.count != 0) {
                let categoryQuiz = CategorizedQuizzes(category: category, quizzes: quizzes)
                sortedData.append(categoryQuiz)
            }
        }
        return sortedData
    }
    
    static func setImage(imageURL: URL) -> UIImage {
        guard let imageData = try? Data(contentsOf: imageURL) else { return UIImage() }
        let image = UIImage(data: imageData) ?? UIImage()
        return image
    }
    
    static func underlineText(button: UIButton, text: String) {
        let attributedString = NSMutableAttributedString.init(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 2,
                                      range: NSRange.init(location: 0, length: attributedString.length));
        button.setAttributedTitle(attributedString, for: .normal)
    }
}
