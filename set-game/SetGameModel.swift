import Foundation

struct SetGameModel {
    let cardsInASet = 3
    let initialDrawAmount = 1
    
    private var standardDeck: [Card] = []
    
    private(set) var currentDeck: [Card] = []
    private(set) var cardsInPlay: [Card] = []
    private(set) var selectedCards: [Card] = []
    
    init() {
        standardDeck = buildDeck()
        startNewGame()
    }
    
    mutating func startNewGame() -> Void {
        currentDeck = standardDeck.shuffled()
        cardsInPlay = []
        selectedCards = []
        
        deal(cardsToDraw: initialDrawAmount)
    }
    
    func buildDeck() -> [Card] {
        let numberOfShapes = [1, 2, 3]
        let shapeTypes = Shape.allCases
        let shadingTypes = Shading.allCases
        let colors = Color.allCases
        
        var deck: [Card] = []
        
        for number in numberOfShapes {
            for shapeType in shapeTypes {
                for shadingType in shadingTypes {
                    for color in colors {
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
        
        return deck
    }
    
    mutating func deal(cardsToDraw cardCount: Int? = nil) -> Void {
        let drawAmount = cardCount ?? cardsInASet
        for _ in 0..<drawAmount {
            cardsInPlay.append(currentDeck.removeFirst())
        }
    }
    
    mutating func select(card: Card) -> Void {
        if selectedCards.count == cardsInASet {
            if hasMadeASet(selectedCards[0], selectedCards[1], selectedCards[2]) {
                for card in selectedCards {
                    if let i = cardsInPlay.firstIndex(of: card) {
                        cardsInPlay.remove(at: i)
                    }
                }
                
                deal()
            }
            else {
                selectedCards = [card]
            }
        }
        else {
            selectedCards.append(card)
        }
    }
    
    mutating func deselect(card: Card) -> Void {
        if selectedCards.count < cardsInASet {
            if let i = selectedCards.firstIndex(of: card) {
                selectedCards.remove(at: i)
            }
        }
    }
    
    func hasMadeASet(_ a: Card, _ b: Card, _ c: Card) -> Bool {
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
            case .oval: "O"
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
