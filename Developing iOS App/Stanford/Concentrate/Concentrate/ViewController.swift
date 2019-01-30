import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2 
    }
    
    private(set) var flipCount = 0 {
        didSet{
            flipCountLevel.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBOutlet private weak var flipCountLevel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("Choosen card was not here")
        }
    }
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = ["🎃","👻","👽","😎","🌲","🐓","🦇","⌘","🎓"]
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        //place back to back if-else in single line. Check emojiChoice is greter 0 or not
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            //let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count))) //unsign random cast in signed
            //emoji[card.identifier] = emojiChoices.remove(at: randomIndex) // put things into emoji dict and remove it ( prevent second time use)
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int{
    var arc4random: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
        return -Int(arc4random_uniform(UInt32(self)))
        }else{
            return 0
        }
    }
}
