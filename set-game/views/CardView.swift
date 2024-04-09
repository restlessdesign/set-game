import SwiftUI
import Foundation

struct CardView: View {
    let card: SetGameModel.Card
    init(_ card: SetGameModel.Card) {
        self.card = card
    }
    
    var body: some View {
        let color:Color = switch card.color {
            case .green: .green
            case .red: .red
            case .purple: .purple
        }
        
        VStack {
            ForEach(0..<card.number) { _ in
                Text("\(card.shape)")
                    .background(color)
                    .padding(10)
            }
        }
//        Text("\(card.number)")
//        Text("\(card.shape)")
//        Text("\(card.shading)")
//        Text("\(card.color)")
    }
}

#Preview {
    CardView(SetGameModel.Card(
        number: 1,
        shape: .diamond,
        shading: .solid,
        color: .green
    ))
}
