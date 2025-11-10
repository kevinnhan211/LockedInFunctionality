import SwiftUI

struct ContentView: View {
    @State private var noteTakingOn = false
    @State private var currentlyInNote = false
    
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
                
                Spacer()
                
                // Bottom Button Section
                if !noteTakingOn {
                    bottomButton(iconName: "NoteTakingIcon") {
                        noteTakingOn = true
                    }
                } else {
                    if !(currentlyInNote) { // Not in note
                        // Section Title
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.black).opacity(0.2)
                                .frame(width: 250, height: 50)
                            
                            Text("Your Notes")
                                .font(.custom("Futura Medium", size: 25))
                                .foregroundStyle(.white)
                        }
                        .offset(y:-250)
                    
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
                        .offset(y:-250)
                        
                        bottomButton(iconName: "PencilIcon", rotation: 35) {
                            currentlyInNote = true
                            notes.append("Untitled Note")
                            noteId = notes.count-1
                        }
                    } else { // User in note document
                        // Top bar in note document
                        VStack(spacing:20) {
                            ZStack {
                                Rectangle().opacity(0.2)
                                    .frame(width:.infinity, height:120)
                                
                                HStack {
                                    // Back button
                                    Button(action:{
                                        currentlyInNote = false
                                        noteTakingOn = true
                                    }) {
                                        Text("Back")
                                            .font(.custom("Futura Medium", size: 25))
                                            
                                        Image(systemName: "return")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25,height: 25)
                                    }
                                    .offset(x:25)
                                    
                                    // Document name
                                    TextField("", text: $notes[noteId])
                                    .font(.custom("Futura Medium", size: 25))
                                    .foregroundColor(.white)
                                    .autocorrectionDisabled()
                                    .offset(x:40)
                                    
                                    // Share button
                                    Button(action:{
                                        
                                    }) {
                                        Image(systemName: "square.and.arrow.up")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30,height: 30)
                                    }
                                    .offset(x:-25)
                                    
                                    // Add friend button
                                    Button(action:{
                                        
                                    }) {
                                        Image(systemName: "person.badge.plus")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30,height: 30)
                                    }
                                    .offset(x:-20,y:5)
                                }
                                .offset(y:15)
                                .foregroundStyle(.white)
                            }
                            
                        }
                        .ignoresSafeArea()
                        .offset(y:-300)
                        
                        Spacer()
                        
                        bottomButton(iconName: "PencilIcon", rotation: 35) {
                        }
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
