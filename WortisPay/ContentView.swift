import SwiftUI

struct AuthenticationPage: View {
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    var body: some View {
        ZStack {
            Color(hex: 0x006699).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 9) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top, 10)
                
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(.white)
                        TextField("", text: $phoneNumber)
                            .foregroundColor(.white) // Couleur du texte
                            .placeholder(when: phoneNumber.isEmpty) { // Placeholder personnalisé
                                Text("Entrez votre numéro de téléphone")
                                    .foregroundColor(.white.opacity(0.5)) // Couleur du placeholder
                            }
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(25)
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.white)
                        if isPasswordVisible {
                            TextField("", text: $password)
                                .foregroundColor(.white) // Couleur du texte
                                .placeholder(when: password.isEmpty) { // Placeholder personnalisé
                                    Text("Entrez votre mot de passe")
                                        .foregroundColor(.white.opacity(0.5)) // Couleur du placeholder
                                }
                        } else {
                            SecureField("", text: $password)
                                .foregroundColor(.white) // Couleur du texte
                                .placeholder(when: password.isEmpty) { // Placeholder personnalisé
                                    Text("Entrez votre mot de passe")
                                        .foregroundColor(.white.opacity(0.5)) // Couleur du placeholder
                                }
                        }
                        Button(action: { isPasswordVisible.toggle() }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(25)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Button(action: {
                    // Action de connexion
                }) {
                    Text("Se connecter")
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: 0x006699))
                        .frame(width: 200) // Largeur fixe du bouton
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                }
                .padding(.top, 13)
                
                Button("Mot de passe oublié ?") {
                    // Action pour mot de passe oublié
                }
                .foregroundColor(.white)
                
                HStack {
                    Text("N'avez-vous pas un compte ?")
                        .foregroundColor(.gray)
                    Button("Créer un compte") {
                        // Action pour créer un compte
                    }
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                }
                .padding(.bottom, 1)
                .padding(.top, 50)
            }
        }
    }
}

extension View {
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            self
            if shouldShow {
                placeholder().padding(.leading, 5) // Ajustez le padding selon vos besoins
            }
        }
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct AuthenticationPage_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationPage()
    }
}
