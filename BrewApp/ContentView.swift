//
//  ContentView.swift
//  BrewApp
//
//  Created by Rasmus Nielsen on 02/07/2020.
//  Copyright © 2020 Rasmus Nielsen. All rights reserved.
//

import SwiftUI

struct CircleView: View {
    @State var model: RecipeModel
    @State var elasped: Double = 0
    @State var brewing: Bool = false
    @State var timer: Timer?
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.yellow)
                .frame(width: 270, height: 270)
            VStack(){
                Text(model.name)
                Text(model.description)
                
                if (model.countdown > 0 && brewing == false) {
                    Button(action: {
                        self.startCountdown(time: self.model.countdown)
                    }) {
                        Text("Start")
                    }
                } else if (brewing == true) {
                    Button(action: {
                        self.stopCountdown()
                    }) {
                        Text("Stop")
                    }
                }
                Text(String(format: "%.1f", Double(model.countdown - elasped)))
            }
        }
    }
    func stopCountdown() {
        if let timer = self.timer {
            print("stopping.")
            self.brewing = false
            timer.invalidate()
        }
    }
    
    func startCountdown(time: Double){
        self.elasped += 0.1
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            // Increment the timer for each tick.
            self.elasped += 0.1
            self.brewing = true
            
            print("brewing...")
            
            // Check if timer has run long enough.
            if (self.elasped >= time) {
                print("done brewing.")
                
                // Reset timer
                self.elasped = 0
                self.brewing = false
                
                // Invalidating timer
                timer.invalidate()
            }
        }
    }
}

struct RecipeModel: Identifiable {
    let id: Int
    let name: String
    let description: String
    let countdown: Double
}

struct ContentView: View {
    
    let recipes: [RecipeModel] = [
        .init(id: 0, name: "Intro", description: " Weight out 16 g of coffee for a single cup of 250 ml water / 32 g for 500 ml of water", countdown: 0.0),
        .init(id: 1, name: "Grind", description: " Grind the coffee on a medium-coarse setting. The grind size has a big impact on taste so experiment on your own grinder for best results. Bitter and dry: grind coarser. Sour and thin: grind finer", countdown: 20.0),
        .init(id: 2, name: "Brew", description: "", countdown: 5.0),
    ]
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(recipes, id: \.id) { recipe in
                            CircleView(model: recipe)
                        }
                    }
                }
            }.navigationBarTitle(Text("Kalita Wave"))
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
