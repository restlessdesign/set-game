//
//  ContentView.swift
//  set-game
//
//  Created by Kevin Sweeney on 4/7/24.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View {
        VStack {
            header
            Spacer()
            gameArea
            Spacer()
            gameActions
        }
    }
    
    var header: some View {
        VStack {
            Button("New Game", systemImage: "folder.fill.badge.plus") {
                viewModel.newGame()
            }
            .buttonStyle(.bordered)
            .controlSize(.mini)
            Divider()
        }
    }
    
    var gameArea: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50, maximum: 90))]) {
                ForEach(viewModel.cardsInPlay) { card in
                    CardView(card)
                        .onTapGesture {
                            viewModel.select(card)
                        }
                }
            }
        }
    }
    
    var gameActions: some View {
        Group {
            Button {
                viewModel.deal()
            } label: {
                Text("Deal")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .fontWeight(.bold)
            .controlSize(.large)
            .disabled(false)
        }
        .padding(.horizontal, 50)
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
