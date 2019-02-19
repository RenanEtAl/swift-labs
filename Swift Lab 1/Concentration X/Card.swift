//
//  Card.swift
//  Concentration X
//
//  Created by Renanie Tanola on 2/9/19.
//  Copyright © 2019 cmpe137. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    var hasBeenFlipped = false
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
