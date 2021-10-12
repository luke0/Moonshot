//
//  AstronautView.swift
//  Moonshot
//
//  Created by Luke Inger on 12/10/2021.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {

        GeometryReader { geometry in
            ScrollView{
                VStack{
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                    
                    ForEach(self.missions, id: \.displayName){ mission in
                        HStack{
                            Image(mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth:50)
                            VStack {
                                Text(mission.displayName)
                                Text(mission.formattedLaunchDate)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut){
        
        self.astronaut = astronaut
        var matches = [Mission]()
        let allMissons:[Mission] = Bundle.main.decode("missions.json")
        
        for mission in allMissons{
            for crew in mission.crew {
                if let _ = allMissons.first(where: { _ in crew.name == astronaut.id }){
                    matches.append(mission)
                }
            }
        }
        
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronaut: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronaut[0])
    }
}
