//
//  Concentration.swift
//  Concentration X
//
//  Created by Renanie Tanola on 2/9/19.
//  Copyright © 2019 cmpe137. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var flipCount = 0
    var points = 0
    private var indexOfOneAndOnlyOneFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                // cards are matched; add 3 points
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    points += 3
                } else {
                    deductPoint(card: cards[index])
                    deductPoint(card: cards[matchIndex])
                    cards[index].hasBeenFlipped = true
                    cards[matchIndex].hasBeenFlipped = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOneFaceUpCard = nil
            } else {
                // this is the case of whether there are two or more
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                    
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOneFaceUpCard = index
            }
        }
    }
    // 1 point deduction
    private func deductPoint(card: Card) {
        if (card.hasBeenFlipped) {
            points -= 1
        }
    }
    
    // initializer
    init(numberOfPairsOfCards: Int){
        //var unshuffledCards: [Card] = []
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()

    }
    //TODO: shuffle cards

    
}
