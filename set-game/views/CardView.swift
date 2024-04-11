import SwiftUI
import Foundation

struct CardView: View {
    let data: SetGameModel.Card
    init(_ data: SetGameModel.Card) {
        self.data = data
    }
    
    var body: some View {
        let color:Color = switch data.color {
            case .green: .green
            case .red: .red
            case .purple: .purple
        }
        
        let shading:Color = switch data.shading {
            case .open: .white
            case .striped: .black
            case .solid: .black
        }
        
        VStack {
            ForEach(0..<data.number, id: \.self) { _ in
                ZStack {
                    Rectangle()
                        .fill(color)
                        .opacity(data.shading == .striped ? 0.5 : 1)
                        .border(.pink, width: data.isSelected ? 10 : 0)
                    
                    Text("\(data.shape)")
                        .padding(10)
                        .foregroundColor(shading)
                        
                }
                
            }
        }
    }
}

#Preview {
    CardView(SetGameModel.Card(
        number: 1,
        shape: .diamond,
        shading: .solid,
        color: .green,
        isSelected: true
    ))
}
