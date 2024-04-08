//
//  ContentView.swift
//  set-game
//
//  Created by Kevin Sweeney on 4/7/24.
//

import SwiftUI

struct SetGameView: View {
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
                print("New game")
            }
            .buttonStyle(.bordered)
            .controlSize(.mini)
            Divider()
        }
    }
    
    var gameArea: some View {
        VStack {
            Text("TODO")
        }
    }
    
    var gameActions: some View {
        Group {
            Button {
                print("Deal")
            } label: {
                Text("Deal")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .fontWeight(.bold)
            .controlSize(.large)
            .disabled(true)
        }
        .padding(.horizontal, 50)
    }
}

#Preview {
    SetGameView()
}
