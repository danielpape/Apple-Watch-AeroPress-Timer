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
        VStack(alignment: .leading, spacing: 4.0){
            Text("Set Brew Time")
            HStack{
                Picker(selection: $brewMins, label: Text("Minutes"), content: {
                    ForEach(0..<11){min in
                    Text("\(min)").tag(min)
                    }
                })
                Text(":")
                Picker(selection: $brewSecs, label: Text("Seconds"), content: {
                    ForEach(0..<60){sec in
                    Text("\(sec)").tag(sec)
                    }
                })
            }
            Spacer()
            NavigationLink(
                destination: BrewView(count: brewMins*60+brewSecs, staticCount: brewMins*60+brewSecs),
                label: {
                    Text("Begin")
                }
            )
            .background(Color.green)
            .clipShape(Capsule()
            )
            .navigationTitle("Brewsta")
        }
    }
}

struct BrewView:View{
    
    @State private var to: CGFloat = 1
    @State var count = 150
    
    var staticCount = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View{

        ZStack{
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.white.opacity(0.09),style: StrokeStyle(lineWidth: 16, lineCap: .round))
            //                .frame(width: 280, height: 280, alignment: .center)
            Circle()
                .trim(from: 0, to: self.to)
                .stroke(Color.green,style: StrokeStyle(lineWidth: 16, lineCap: .round))
                .rotationEffect(.init(degrees: -90))
            Text(count == 0 ? "Enjoy" : "\(count/60):\(String(format: "%02d", count%60))")
                .navigationTitle("Brew")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .onReceive(timer) { time in
                    print("active")
                    count-=1
                    WKInterfaceDevice.current().play(.click)
                    withAnimation(.default){
                        self.to = CGFloat(self.count)/CGFloat(staticCount)
                    }
                    
                    if(count==30){
                        WKInterfaceDevice.current().play(.start)
                    }
                    
                    if(count==0){
                        self.timer.upstream.connect().cancel()
                    }
                }
        }.padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
