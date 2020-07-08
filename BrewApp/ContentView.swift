//
//  ContentView.swift
//  BrewApp
//
//  Created by Rasmus Nielsen on 02/07/2020.
//  Copyright © 2020 Rasmus Nielsen. All rights reserved.
//

import SwiftUI

let countDowntime = 5

 // Variable to hold the elasped time
 var elasped: Int = 0
 // Variable to indicate each tick in seconds
 let interval: Double = 1.0

func testingTimer(){
   Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
     // Increment the timer for each tick.
     elasped += Int(interval)
     
     print("brewing...")
     
     // Check if timer has run long enough.
     if (elasped >= countDowntime) {
         print("done brewing.")
         
         // Invalidating timer
         timer.invalidate()
     }
   }
}


struct CircleView: View {
  
  @State var model: RecipeModel
  //@State var countdownforview: Float

  var body: some View {
    
        ZStack {
            Circle()
                .fill(Color.yellow)
                .frame(width: 270, height: 270)
          VStack(){
            Text(model.name)
            Text(model.description)
            
            if (model.CountdownTime > 0){
             Button(action: {
                testingTimer()
             }) {
                           Text("Start timer")
                       }
              
              Text(String(model.CountdownTime))
            }
          }
        }
    }
}

struct RecipeModel: Identifiable {
  let id: Int
  let name: String
  let description: String
  let CountdownTime: Float
}

struct ContentView: View {

  let recipes: [RecipeModel] = [
    .init(id: 0, name: "Intro", description: " Weight out 16 g of coffee for a single cup of 250 ml water / 32 g for 500 ml of water", CountdownTime: 0.0),
    .init(id: 1, name: "Grind", description: " Grind the coffee on a medium-coarse setting. The grind size has a big impact on taste so experiment on your own grinder for best results. Bitter and dry: grind coarser. Sour and thin: grind finer", CountdownTime: 20.0),
    .init(id: 2, name: "Brew", description: "", CountdownTime: 0.0),
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
