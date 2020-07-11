//
//  ContentView.swift
//  BrewApp
//
//  Created by Rasmus Nielsen on 02/07/2020.
//  Copyright © 2020 Rasmus Nielsen. All rights reserved.
//

import SwiftUI

struct CircleView: View {
  
  
    @State var model: Recipe
    @State var elasped: Double = 0
    @State var brewing: Bool = false
    @State var timer: Timer?
  
  
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.yellow)
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
          }.background
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

struct ContentView: View {
    @State var recipes: Array<Recipe>

    var body: some View {
 
      
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(recipes, id: \.id) { recipe in
                            CircleView(model: recipe)
                        }
                    }
                    
                }.navigationBarTitle(Text("Kalita Wave"))
                
            }

            
        }
        
    }
}

// TODO: Unsure about this here.
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
