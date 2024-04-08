import Foundation

struct SetGameModel {
    private var deck: [SetCard]
    private(set) var cardsInPlay: [SetCard]
    
    private let numberOfShapes = [1, 2, 3]
    private let shapeTypes = SetShape.allCases
    private let shadingTypes = SetShading.allCases
    private let colors = SetColor.allCases
    
    init() {
        deck = []
        cardsInPlay = []
        
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
        
        deck.shuffle()
        deal(cardsToDraw: 12)
    }
    
    mutating func deal(cardsToDraw cardCount: Int = 3) -> Void {
        for _ in 0..<cardCount {
            cardsInPlay.append(deck.removeFirst())
        }
    }
    
    func checkIfSet(_ a: SetCard, _ b: SetCard, _ c: SetCard) -> Bool {
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
