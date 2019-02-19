//
//  ViewController.swift
//  Concentration X
//
//  Created by Renanie Tanola on 2/2/19.
//  Copyright © 2019 cmpe137. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    private lazy var game = newConcentration()

    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    private(set) var pointCount = 0 {
        didSet {
            pointsLabel.text = "Points: \(pointCount)"
        }
    }
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var pointsLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    // starts new game, "face down" cards, and assign new emojis
    @IBAction private func newGame(_ sender: UIButton) {
        game = newConcentration()
        updateViewFromModel()
        emojiChoices = newEmojiChoices()
    }
    
    private func newConcentration() -> Concentration {
        return Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    }
    // themes are foods, transportation, sports , animals, hand signs
    private var themes = [
        ["🍎","🥯","🌶","🍔","🍟","🍕","🌮","🍱","🍩","🍷","🌭","🥑","🥦"],
        ["🚗","🚕","🚌","🛴","🚲","🛩","⛵️","🚜","🚅","🚔","🚂","✈️","🚁"],
        ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🎱","⛸","🥊","🛹","🏄‍♂️"],
        ["🐱","🦊","🐻","🐼","🐵","🐧","🐨","🐶","🐔","🐺","🦄","🐬","🦋"],
        ["🤜","🖐","☝️","🤛","👋","🤙","👌","🖖","✌️","👊","👍","🤘","🤟"]
    ]
    private lazy var emojiChoices: [String] = newEmojiChoices()
    // add new random theme
    private func newEmojiChoices() -> [String] {
        return themes[Int(arc4random_uniform(UInt32(themes.count)))]
    }
    
    var emoji = [Int:String]()
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen Card was not in cardButton")
        }
        
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji( for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        pointsLabel.text = "Points: \(game.points)"
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }


}

