//
//  ContentView.swift
//  aeropresstimer WatchKit Extension
//
//  Created by Daniel Pape on 31/07/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var brewMins: Int = 1
    @State private var brewSecs: Int = 0

//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    let duration = 20
    
    var body: some View {
            VStack{
                HStack{
                    Picker(selection: $brewMins, label: Text("Mins"), content: {
                        Text("0").tag(0)
                    Text("1").tag(1)
                    Text("2").tag(2)
                        Text("3").tag(4)
                        Text("4").tag(4)
                })
                    Picker(selection: $brewSecs, label: Text("Secs"), content: {
                    Text("1").tag(1)
                    Text("2").tag(2)
                })
                }
            Spacer()
                NavigationLink(
                    destination: BrewView2(),
                    label: {
                        Text("Begin")
                    }
            )
        .navigationTitle("Brewsta")
    }
}
}

struct BrewView2:View{

    @State private var length: Int = 20
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View{
        Text("\(length)")
            .navigationTitle("Brew")
            .onReceive(timer) { time in
                print("active")
                length=length-1
                
                if(length==0){
                    self.timer.upstream.connect().cancel()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
