//
//  ContentView.swift
//  SwiftUI-NavigationStack
//
//  Created by İsmail Can Akgün on 15.05.2024.
//

import SwiftUI


// MARK: ÖZET
/* NavigationDestination: Belirli bir duruma veya değere bağlı olarak hedef görünümler tanımlar.
 
NavigationStack(path:): Bir navigasyon yığını oluşturur ve belirli bir yolu takip ederek görünümler arasında geçiş yapmanızı sağlar.
 
NavigationLink: İki görünüm arasında geçiş yapmayı sağlar.
*/
    struct ContentView: View {
        
        var platforms: [Platform] = [.init(name: "Xbox", imageName: "xbox.logo", color: .green),
                                    .init(name: "Playstation", imageName: "playstation.logo", color: .indigo),
                                    .init(name: "PC", imageName: "pc", color: .pink),
                                    .init(name: "Mobile", imageName: "iphone", color: .mint)]
        
        var games: [Game] = [.init(name: "Minecraft", rating: "99"),
                             .init(name: "God of War", rating: "98"),
                             .init(name: "Fornite", rating: "92"),
                             .init(name: "Madden 2023", rating: "88")]
        
        @State private var path = NavigationPath()
        
        var body: some View {
            
            // NavigationStack(path:), SwiftUI'de bir navigasyon yığını oluşturmak için kullanılır. Bu, belirli bir yolu (path) takip ederek görünümler arasında geçiş yapmanızı sağlar. NavigationStack ile bir dizi (array) veya başka bir veri yapısını takip ederek navigasyon oluşturabilirsiniz.
            NavigationStack(path: $path) {
                List{
                    Section("Platforms") {
                        ForEach(platforms, id: \.name) { platform in
                            //NavigationLink, SwiftUI'de iki görünüm arasında geçiş yapmak için kullanılan bir yapı taşıdır. Bir düğme veya başka bir etkileşim öğesi olarak görünür ve tıklanması veya seçilmesi durumunda belirli bir hedefe geçiş yapar.
                            NavigationLink(value: platform) {
                                Label(platform.name, systemImage: platform.imageName)
                                    .foregroundColor(platform.color)
                            }
                        }
                    }
                    
                    Section("Games") {
                        ForEach(games, id: \.name) { game in
                            NavigationLink(value: game) {
                                Text(game.name)
                            }
                        }
                    }
                }
                .navigationTitle("Gaming")
                .navigationDestination(for: Platform.self) { platform in
                    ZStack {
                        platform.color.ignoresSafeArea()
                        VStack {
                            Label(platform.name, systemImage: platform.imageName)
                                .font(.largeTitle).bold()
                            
                            List {
                                ForEach(games, id: \.name) { game in
                                    NavigationLink(value: game) {
                                        Text(game.name)
                                    }
                                }
                                
                            }
                        }
                    }
                }
                // NavigationDestination, SwiftUI'de, belirli bir duruma veya değere bağlı olarak hedef (destination) görünümleri belirlemek için kullanılan bir modifiyerdir. Bu, uygulamanızda farklı durumlarda farklı hedeflere geçiş yapmanızı sağlar.
                .navigationDestination(for: Game.self) { game in
                    VStack(spacing: 20) {
                        Text("\(game.name) - \(game.rating)")
                            .font(.largeTitle).bold()
                        
                        Button("Recommended game") {
                            path.append(games.randomElement()!)
                        }
                        
                        Button("Go to another platform") {
                            path.append(platforms.randomElement()!)
                        }
                        
                        Button("Go Home") {
                            path.removeLast(path.count)
                        }
                    }
            }
        }
        .accentColor(.black)
    }
}
    
    #Preview {
        ContentView()
    }
    
struct Platform: Hashable {
        let name: String
        let imageName: String
        let color: Color
    }

struct Game: Hashable {
    let name: String
    let rating: String
}
