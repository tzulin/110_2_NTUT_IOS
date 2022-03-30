//
//  Card.swift
//  CardMatchingGame
//
//  Created by 郭梓琳 on 2022/3/16.
//
// MVC: model

import Foundation

// Struct
//   - no inheritance
//   - copy by value (Copy-On-Write Semantics)
struct Card {
    var isCardFront = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init () {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    /*
    init(外部參數名 內部參數名: 型態)
        init(identifier i: Int) {
             identifier = i
        }
    or
        init(indentifier i: Int) {
            self.identifier = i
        }
    or
        init(indentifier : Int) {
            self.identifier = identifier
        }
    */
}
