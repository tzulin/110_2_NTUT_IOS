//
//  ViewController.swift
//  CardMatchingGame
//
//  Created by 郭梓琳 on 2022/3/9.
//
// MVC: controller

// #colorLiteral(red: 0, green: 0, blue: 0, alpha:1)
// UIButton.configuration?.baseBackgroundColor = #colorLiteral(red: 0.8881677389, green: 0.7909854054, blue: 0.6456608772, alpha: 1)

import UIKit

class ViewController: UIViewController {

    @IBOutlet var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    private var _emojiList: [String] = ["🐶", "🦊", "🐯", "🐨"]
    // declare Dictionary 寫法:
    //      var _emojiDic: Dictionary<Int, String>
    //      var _emojiDic = Dictionary<Int, String>()
    //      var _emojiDic = [Int:String]()
    private var _emojiDic: Dictionary<Int, String> = Dictionary<Int, String>()
    private var _firstCardIndex: Int = 0

    // lazy: 有人使用的時候，才會去初始化（不能用 didSet）
    //（通常應避免使用 lazy，還是直接給常數會比較好，也就是說盡量不要用 cardButtons.count，因為這樣要等 run time 時才給值，就得加 lazy）
//    private lazy var game: MatchingGame = MatchingGame(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    private var game: MatchingGame = MatchingGame(numberOfPairsOfCards: 4)
    private var _fcount: Int = 0
    {
        didSet{
            flipCountLabel.text = "Flips: \(_fcount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // self code
        _emojiList.shuffle()
        for card in cardButtons {
            _changeToCardBack(card: card)
        }
        // end of self code
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber) // 讓 game 去判斷卡片狀態
            updateViewFromModel()   // 處理 UI 顯示
        } else {
            print("not in collection")
        }
        _fcount += 1
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index] // UI 的元件(那張卡片)
            let card = game.cards[index]    // 自己寫的 Card struct
            if card.isCardFront {
                // 翻到正面
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.8881677389, green: 0.7909854054, blue: 0.6456608772, alpha: 1)
            } else {
                // 翻到背面
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.8881677389, green: 0.7909854054, blue: 0.6456608772, alpha: 0.5) : #colorLiteral(red: 0.6775053144, green: 0.5455644727, blue: 0.4498484135, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if _emojiDic[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(_emojiList.count)))
//            _emojiDic[card.identifier] = _emojiList[randomIndex]
            _emojiDic[card.identifier] = _emojiList.remove(at: randomIndex) // 避免抽到一樣的 emoji
        }
        return _emojiDic[card.identifier] ?? "?"
        
//        if _emojiDic[card.identifier] != nil {
//            return _emojiDic[card.identifier]
//        } else {
//            return "?"
//        }
    }
    
    /*
    @IBAction func resetGame(_ sender: Any) {
        _cardEmojiList.shuffle()
        for card in cardButtons {
            _changeToCardBack(card: card)
        }
        _fcount = 0
    }
    
    @IBAction func flipCard(_ sender: UIButton) {
        if sender.currentTitle != "" {
//            if _fcount % 2 != 0 {
                _changeToCardBack(card: sender)
                _fcount += 1
//            }
        }
        else {
            _changeToCardFront(card: sender)
            _fcount += 1
            if _fcount % 2 == 0 {
//                _matchCards(secondCardIndex: _getCardIndex(card: sender));
            }
            else {
                _firstCardIndex = _getCardIndex(card: sender)
            }
        }
    }
     */
    
    private func _changeToCardBack(card: UIButton) {
        card.setTitle("", for: .normal)
        card.backgroundColor = #colorLiteral(red: 0.6775053144, green: 0.5455644727, blue: 0.4498484135, alpha: 1)
    }
    
    private func _changeToCardFront(card: UIButton) {
        let cardIndex: Int = _getCardIndex(card: card)
        card.setTitle(_emojiList[cardIndex], for: .normal)
        card.backgroundColor = #colorLiteral(red: 0.8881677389, green: 0.7909854054, blue: 0.6456608772, alpha: 1)
    }
    
    private func _getCardIndex(card: UIButton) -> Int {
        return cardButtons.firstIndex(of: card)!
    }
    
    private func _matchCards(secondCardIndex: Int) {
        if _emojiList[_firstCardIndex] != _emojiList[secondCardIndex] {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self._changeToCardBack(card: self.cardButtons[self._firstCardIndex])
                self._changeToCardBack(card: self.cardButtons[secondCardIndex])
            }
        }
    }
}
