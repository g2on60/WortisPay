import SwiftUI
import WebKit

struct SplashScreenView: View {
    @State private var isVisible = false

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            Image("AZ") // Remplacez "AZ" par le nom de votre icône d'application
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .opacity(isVisible ? 1 : 0)
                .animation(.easeIn(duration: 1), value: isVisible)
                .onAppear {
                    isVisible = true
                }
        }
    }
}

struct ContentView: View {
    @State private var isSplashActive = true

    var body: some View {
        ZStack {
            if isSplashActive {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isSplashActive = false
                            }
                        }
                    }
            } else {
                TabView {
                    MainView()
                        .tabItem {
                            Label("Accueil", systemImage: "house")
                        }

                    SettingsView()
                        .tabItem {
                            Label("Partenaires", systemImage: "person.2") // Icône native pour Partenariat
                        }
                }
            }
        }
    }
}

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer().frame(height: 0)
                HeaderView()
                
                ScrollView {
                    VStack(spacing: 16) {
                        BannerView()
                            .frame(height: 150) // La hauteur de la bannière
                            .padding(.top, 20) // Padding en haut pour descendre la bannière

                        CardsGridView()
                    }
                    .padding(.horizontal, 0) // Suppression des marges horizontales
                }
            }
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Image("logowpay")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 30)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(red: 0/255, green: 102/255, blue: 153/255)) // Couleur #006699
        .frame(height: 44, alignment: .top)
    }
}

struct BannerView: View {
    var body: some View {
        Image("banniere-apk")
            .resizable()
            .scaledToFill()
            .clipped()
            .cornerRadius(2)
            .frame(maxWidth: .infinity) // Prendre toute la largeur disponible
            .padding(.horizontal, 0) // Supprimer les marges
    }
}

struct Card: Identifiable {
    let id = UUID()
    let imageName: String
    let url: URL
}

struct CardsGridView: View {
    let cards: [Card] = [
        Card(imageName: "SPEED-min", url: URL(string: "https://speed.wortispay.com/")!),
        
        Card(imageName: "scolarite", url: URL(string: "https://scolarite.wortispay.cg")!),
        Card(imageName: "payer-gaz-gpl", url: URL(string: "https://gpl.wortispay.cg")!),
        Card(imageName: "Banniere_billet", url: URL(string: "https://ebillet.wortispay.cg")!),
        Card(imageName: "vival", url: URL(string: "https://vival.wortispay.cg")!),
        Card(imageName: "payer-afric-gasoil", url: URL(string: "https://gpl.wortispay.cg/")!),
        Card(imageName: "payer-icc-congo", url: URL(string: "https://icccongo.wortispay.cg")!),
        Card(imageName: "Banniere_rehoboth_min", url: URL(string: "https://rehoboth.wortispay.cg")!),
        Card(imageName: "Banniere_tjc_min", url: URL(string: "https://tjc.wortispay.cg")!),
        Card(imageName: "Banniere_zen_min", url: URL(string: "https://cinezen.wortispay.cg")!),
        Card(imageName: "LocationG5", url: URL(string: "https://rentalcar.wortispay.cg/")!),
        Card(imageName: "payer-carte-virtuo", url: URL(string: "https://virtuo.wortispay.cg")!),
        Card(imageName: "E-depot-min", url: URL(string: "https://edepot.wortispay.cg")!),
        Card(imageName: "pelissa", url: URL(string: "https://pelissa.wortispay.cg")!),
        Card(imageName: "euroshop", url: URL(string: "https://euroshop.wortispay.cg")!),
        Card(imageName: "Parfums", url: URL(string: "https://parfums.wortispay.cg")!),
        Card(imageName: "Banniere_taxi", url: URL(string: "https://taxig5.wortispay.cg")!),
        Card(imageName: "DimancheZEN", url: URL(string: "https://dimanchezen.wortispay.cg")!),
        Card(imageName: "Exa_min", url: URL(string: "https://scolarite.wortispay.cg")!)
    ]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
            ForEach(cards) { card in
                NavigationLink(destination: WebView(url: card.url)) {
                    CardView(imageName: card.imageName)
                }
            }
        }
        .padding()
    }
}

struct CardView: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(height: 100)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
    }
}

struct WebView: View {
    let url: URL
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            WebViewRepresentable(url: url)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
                    .padding()
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 2)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
    }
}

struct WebViewRepresentable: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}



struct PartnerCardsGridView: View {
    let cards: [Card] = [
        Card(imageName: "SUNU", url: URL(string: "https://apps.apple.com/cg/app/mysunu-assurances/id6444869239?l=fr-FR")!),
        Card(imageName: "gmercury", url: URL(string: "https://gmercury-cie.com")!),
        Card(imageName: "boutique-elle-et-lui", url: URL(string: "https://www.elleetluishop.com")!)
    ]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
            ForEach(cards) { card in
                Button(action: {
                    openURL(card.url)
                }) {
                    CardView(imageName: card.imageName)
                }
            }
        }
        .padding()
    }
    
    private func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

struct SettingsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 8) { // Réduction de l'espacement vertical
                HeaderView()
                                
                PartnerCardsGridView()
            }
            .padding(.horizontal, 0)
        }
        .navigationTitle("Partenaires")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
