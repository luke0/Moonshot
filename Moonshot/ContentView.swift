//
//  ContentView.swift
//  Moonshot
//
//  Created by Luke Inger on 08/10/2021.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingAstronauts: Bool = false
    
    var body: some View {
        NavigationView {
            if (!showingAstronauts) {
                List(missions) { mission in
                    NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)){
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
                .navigationBarTitle("Moonshot")
                .navigationBarItems(trailing: Button(action: {
                    showingAstronauts.toggle()
                }, label: {
                    Text(showingAstronauts ? "Show Missions" : "Show Astronauts")
                }))
            } else {
                List(astronauts) { astronaut in
                    NavigationLink(destination: AstronautView(astronaut: astronaut)){
                        Image(astronaut.id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        Text(astronaut.name)
                            .font(.headline)
                    }
                }
                .navigationBarTitle("Moonshot")
                .navigationBarItems(trailing: Button(action: {
                    showingAstronauts.toggle()
                }, label: {
                    Text(showingAstronauts ? "Show Missions" : "Show Astronauts")
                }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
