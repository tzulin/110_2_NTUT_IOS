//
//  MatchingGame.swift
//  CardMatchingGame
//
//  Created by 郭梓琳 on 2022/3/16.
//
// MVC: model

import Foundation

// Class
//   - has inheritance
//   - copy: return by reference (lives in heap, get pointers to it)
class MatchingGame {
    // declare Array 寫法:
    //      var cards: Array<Card> = Array()
    //      var cards: [Card] = []()
    //      var cards: [Card] = []
    //      var cards = [Card]()
    public var cards: Array<Card> = Array()
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }
    
    public func chooseCard(at index: Int) {
        if cards[index].isCardFront {
            cards[index].isCardFront = false
        } else {
            cards[index].isCardFront = true
        }
    }
    
    
    /* self code
    // init how many pairs of cards
    public init(numberOfPairsOfCards: Int) {
        for i in 0..<numberOfPairsOfCards {
            // generate a pair of cards (two cards with same identifier)
            cards.append(Card(identifier: i))
            cards.append(Card(identifier: i))
        }
    }
    */
    
    /* teacher code
    public init(numberOfPairsOfCards: Int) {
        for i in 1...numberOfPairsOfCards {
            // generate a pair of cards (two cards with same identifier)
            let card = Card(identifier: i)
            cards.append(card)
            let matchingCard = Card(identifier: i)  // or `let matchingCard = card`  (struct: copy by value)
            cards.append(matchingCard)
            /* or let card = Card(identifier: i)
                  cards += [card, card] */
        }
    }
     */
}
