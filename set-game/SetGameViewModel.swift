import Foundation

class SetGameViewModel: ObservableObject {
    @Published private var model = createSetGame()

    private static func createSetGame() -> SetGameModel {
        return SetGameModel()
    }
    
    var deck: [SetGameModel.Card] {
        model.currentDeck
    }
    
    var cardsInPlay: [SetGameModel.Card] {
        model.cardsInPlay
    }
    
    var selectedCards: [SetGameModel.Card] {
        model.selectedCards
    }
    
    // MARK: - Intents
}
