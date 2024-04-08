import Foundation

struct SetGameModel {
    let cardsInASet = 3
    let initialDrawAmount = 12
    
    private let numberOfShapes = [1, 2, 3]
    private let shapeTypes = SetShape.allCases
    private let shadingTypes = SetShading.allCases
    private let colors = SetColor.allCases
    
    private var standardDeck: [SetCard] = []
    
    private(set) var activeDeck: [SetCard] = []
    private(set) var cardsInPlay: [SetCard] = []
    private(set) var selectedCards: [SetCard] = []
    
    init() {
        standardDeck = buildDeck()
        startNewGame()
    }
    
    mutating func startNewGame() -> Void {
        activeDeck = standardDeck.shuffled()
        cardsInPlay = []
        selectedCards = []
        
        deal(cardsToDraw: initialDrawAmount)
    }
    
    func buildDeck() -> [SetCard] {
        var deck: [SetCard] = []
        
        for number in numberOfShapes {
            for shapeType in shapeTypes {
                for shadingType in shadingTypes {
                    for color in colors {
                        deck.append(SetCard(
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
        var drawAmount = cardCount ?? cardsInASet
        for _ in 0..<drawAmount {
            cardsInPlay.append(activeDeck.removeFirst())
        }
    }
    
    mutating func select(card: SetCard) -> Void {
        if selectedCards.count == cardsInASet {
            if hasMadeASet(selectedCards[0], selectedCards[1], selectedCards[2]) {
                for selectedCard in selectedCards {
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
    
    mutating func deselect(card: SetCard) -> Void {
        if selectedCards.count < cardsInASet {
            if let i = selectedCards.firstIndex(of: card) {
                selectedCards.remove(at: i)
            }
        }
    }
    
    func hasMadeASet(_ a: SetCard, _ b: SetCard, _ c: SetCard) -> Bool {
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
}

struct SetCard: Equatable {
    let number: Int
    let shape: SetShape
    let shading: SetShading
    let color: SetColor
}

enum SetShape: CaseIterable {
    case diamond, squiggle, oval
}

enum SetShading: CaseIterable {
    case solid, striped, open
}

enum SetColor: CaseIterable {
    case red, green, purple
}
