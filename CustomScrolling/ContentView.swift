//
//  ContentView.swift
//  CustomScrolling
//
//  Created by Zelyna Sillas on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    @State var isInDarkMode: Bool = true
    @State var screenSize: CGSize = CGSize(width: 393, height: 852)
    @State var isHidden: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 25) {
                        Text("Custom Scrolling")
                            .font(.largeTitle)
                            .fontDesign(isInDarkMode ? .default : .rounded)
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                            .shadow(color: isInDarkMode ? .blue.opacity(0.5) : .black.opacity(0.3), radius: isInDarkMode ? 1 : 2, y: 7)
                        
                        toggleSwitch
                    }
                    
                    Rectangle()
                        .frame(width: screenSize.width - 45, height: 2)
                        .foregroundColor(.white.opacity(isInDarkMode ? 0.1 : 0.2))
                }
                .padding(.top, 25)
                .opacity(isHidden ? 0 : 1)
   
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 140) {
                        ForEach(isInDarkMode ? cards : lightCards) { card in
                            CardView(card: card, screenSize: $screenSize, isHidden: $isHidden)
                                .scrollTransition { content, phase in
                                    content
                                        .rotationEffect(.degrees(phase.isIdentity ? 0 : -30))
                                        .rotation3DEffect(.degrees(phase.isIdentity ? 0 : 90), axis: (x: -1, y: 1, z: 0))
                                        .blur(radius: phase.isIdentity ? 0 : 40)
                                    
                                }
                        }
                        .shadow(color: isInDarkMode ? .black.opacity(0.5) : .black.opacity(0.3), radius: 5, y: 15)
                  
                    }
                    .scrollTargetLayout()
                    .padding(.bottom, 30)
                   
                }
                .scrollTargetBehavior(.viewAligned)
                .ignoresSafeArea()
                .offset(y: isHidden ? -70 : 0)
                .onAppear {
                    screenSize = proxy.size
                }
                .onChange(of: proxy.size) { oldValue, newValue in
                    screenSize = newValue
                }
            }
            .background {
                Image(isInDarkMode ? .background : .backgroundLight)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .blur(radius: 20)
                    .padding(-95)
            }
          
            
        }
        .preferredColorScheme(isInDarkMode ? .dark : .light)
        .animation(Animation.easeInOut(duration: 1.5), value: isInDarkMode)
    }
    
    var toggleSwitch: some View {
        Button {
            withAnimation {
                isInDarkMode.toggle()
            }
        } label: {
            if isInDarkMode {
                Image(.moon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(.sun)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(1.1)
            }
        }
        .frame(width: 40, height: 50)
        .shadow(color: isInDarkMode ? .blue.opacity(0.3) : .black.opacity(0.3), radius: 2, y: 4)
    }
}

#Preview {
    ContentView()
}
