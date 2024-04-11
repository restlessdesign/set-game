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
    
    // MARK: - Intents
    
    func newGame() {
        print("\nNew Game")
        model = SetGameViewModel.createSetGame()
    }
    
    func deal() {
        print("\nDeal")
        model.deal()
        
        print("--------------------------------------")
        print("Cards in play:")
        print(cardsInPlay)
        print("--------------------------------------")
    }
    
    func select(_ card: SetGameModel.Card) {
        print("\nSelect", card)
        model.select(card)
    }
}
