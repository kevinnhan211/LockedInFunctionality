import SwiftUI

struct ContentView: View {
    @State private var noteTakingOn = false
    @State private var currentlyInNote = true
    
    @State private var noteId : Int = 0
    
    @State private var notes = ["test"]
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Decorative background image
            Image("bubbleBG")
                .resizable()
                .scaledToFit()
                .opacity(0.25)
                .offset(y: -40)
            
            VStack {
                // Logo + Title
                if !(currentlyInNote) {
                    ZStack {
                        Image("LockInLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 60)
                            .opacity(0.65)
                        
                        Text("Locked In")
                            .font(.custom("Futura Medium", size: 16))
                            .fontWeight(.semibold)
                            .padding(.bottom)
                            .foregroundStyle(.white)
                    }
                }
                
                VStack(spacing:20) {
                    Rectangle()
                    
                }
                
                // Section Title
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.black).opacity(0.2)
                        .frame(width: 250, height: 50)
                    
                    Text("Your Notes")
                        .font(.custom("Futura Medium", size: 25))
                        .foregroundStyle(.white)
                }
            
                
                ScrollView {
                    ForEach(notes.enumerated(), id: \.element) {index, note in
                        Button (action:{
                            noteId = index
                            currentlyInNote = true
                        }) {
                            Text(note)
                                .font(.custom("Futura Medium", size: 20))
                                .foregroundStyle(.white)
                                .frame(width:250)
                                .padding()
                        }
                        .background(Color.buttonColour)
                        .cornerRadius(8)
                    }
                }
                .background(Color.black.opacity(0.2))
                .cornerRadius(8)
                .frame(width:300, height:250)
                
                Spacer()
                
                // Bottom Button Section
                if !noteTakingOn {
                    bottomButton(iconName: "NoteTakingIcon") {
                        noteTakingOn.toggle()
                    }
                } else {
                    if !(currentlyInNote) { // Not in note
                        bottomButton(iconName: "PencilIcon", rotation: 35) {
                            currentlyInNote = true
                            noteId = notes.count-1
                            notes.append("Untitled Note")
                        }
                    } else { // User in note document
                        
                    }
                    
                    
                }
            }
        }
    }
    
    func bottomButton(iconName: String, rotation: Double = 0, action: @escaping () -> Void) -> some View {
        ZStack {
            Rectangle()
                .frame(width: .infinity, height: 100)
                .foregroundStyle(.black).opacity(0.2)
            
            Button(action: action) {
                ZStack {
                    Circle()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.buttonColour)
                    
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(rotation))
                }
            }
        }
        .offset(y:35)
    }
}

#Preview {
    ContentView()
}
