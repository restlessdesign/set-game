import Foundation

struct SetGameModel {
    let cardsInASet = 3
    let initialDrawAmount = 12
    
    let minShapes = 1
    let maxShapes = 3
    
    private var standardDeck: [Card] = []
    
    private(set) var currentDeck: [Card] = []
    private(set) var cardsInPlay: [Card] = []
    
    init() {
        standardDeck = buildDeck()
        startNewGame()
    }
    
    /// Constructs a standard 81-card Set deck based off the permutations.
    /// - Returns: An array of 81 unique Set cards
    func buildDeck() -> [Card] {
        var deck: [Card] = []
        
        for number in minShapes...maxShapes {
            for shapeType in Shape.allCases {
                for shadingType in Shading.allCases {
                    for color in Color.allCases {
                        deck.append(Card(
                            number: number,
                            shape: shapeType,
                            shading: shadingType,
                            color: color
                        ))
                    }
                }
            }
        }
        
        precondition(cardsInPlay.count != 81, "A Set deck should contain exactly 81 cards")
        
        return deck
    }
    
    /// Creates a copy of our standard deck, shuffles it, then deals 12 cards to a fresh game board.
    mutating func startNewGame() {
        currentDeck = standardDeck.shuffled()
        cardsInPlay = []
        
        deal(cardsToDraw: initialDrawAmount)
    }
    
    /// Takes a given amount of cards from the deck and puts them into play.
    /// - Parameter cardCount: A new game should draw 12 cards. Subsequent draws should be 3.
    mutating func deal(cardsToDraw cardCount: Int? = nil) {
        cardsInPlay.append(contentsOf: currentDeck.prefix(cardCount ?? cardsInASet))
    }
    
    mutating func select(_ card: Card) {
        let selectedCards = cardsInPlay.filter({ $0.isSelected })
        
        if let chosenIndex = cardsInPlay.firstIndex(where: { $0 == card }) {
            if selectedCards.count < cardsInASet {
                cardsInPlay[chosenIndex].isSelected.toggle()
            }
            else {
                if setHasBeenMade(forCards: selectedCards) {
                    // If the 3 selected cards are matching, replace them with new ones from the deck (if there are any left)
                    // TODO: Rather than dealing to the bottom of the board, replace the cards in their original positions
                    for card in selectedCards {
                        if let i = cardsInPlay.firstIndex(of: card) {
                            cardsInPlay.remove(at: i)
                        }
                    }
                    
                    deal()
                    
                    // If the selected card was NOT in set of selected cards, select it
                    if !selectedCards.contains(card) {
                        cardsInPlay[chosenIndex].isSelected = true
                    }
                }
                else {
                    // If no set was made, deselect all cards except the one that was just picked
                    for index in cardsInPlay.indices {
                        cardsInPlay[index].isSelected = (index == chosenIndex)
                    }
                }
                
            }
        }
    }
    
    func setHasBeenMade(forCards cards: [Card]) -> Bool {
        let a = cards[0], b = cards[1], c = cards[2]
        
        // TODO: Break this logic into smaller parts or find a way to generalize
        // They all have the same number or have three different numbers
        return (
            (a.number == b.number && b.number == c.number) ||
            (a.number != b.number && a.number != c.number && b.number != c.number)
        ) &&
        // They all have the same shape or have three different shapes
        (
            (a.shape == b.shape && b.shape == c.shape) ||
            (a.shape != b.shape && a.shape != c.shape && b.shape != c.shape)
        ) &&
        // They all have the same shading or have three different shadings
        (
            (a.shading == b.shading && b.shading == c.shading) ||
            (a.shading != b.shading && a.shading != c.shading && b.shading != c.shading)
        ) &&
        // They all have the same color or have three different colors
        (
            (a.color == b.color && b.color == c.color) ||
            (a.color != b.color && a.color != c.color && b.color != c.color)
        )
    }
    
    struct Card: Identifiable, Equatable, CustomDebugStringConvertible {
        let number: Int
        let shape: Shape
        let shading: Shading
        let color: Color
        
        var isSelected: Bool = false
        
        var id: String {
            "\(number)\(shape)\(shading)\(color)"
        }
        
        var debugDescription: String {
            "(\(number), \(shape), \(shading), \(color))"
        }
        
    }

    enum Shape: CaseIterable, CustomDebugStringConvertible {
        case diamond, squiggle, oval
        
        var debugDescription: String {
            switch self {
            case .diamond: "◆"
            case .squiggle: "~"
            case .oval: "⏺︎"
            }
        }
    }

    enum Shading: CaseIterable, CustomDebugStringConvertible {
        case solid, striped, open
        
        var debugDescription: String {
            switch self {
            case .solid: "◼"
            case .striped: "░"
            case .open: "▢"
            }
        }
    }

    enum Color: CaseIterable {
        case red, green, purple
    }
}
