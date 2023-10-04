//
//  CardView.swift
//  CustomScrolling
//
//  Created by Zelyna Sillas on 9/19/23.
//

import SwiftUI

struct CardView: View {
    var card: Card = cards[0]
    @Binding var screenSize: CGSize
    
    @State var isTapped = false
    @State var isPressingEmboss = false
    @State var isPressingPixellate = false
    @Binding var isHidden: Bool
    @State var isActive = false
    @State var isDownloading = false
    
    @State var hasSimpleWave = false
    @State var hasComplexWave = false
    @State var hasNoise = false
    @State var hasEmboss = false
    @State var isPixellated = false
    
    @State var time = Date.now
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let startDate = Date()
    
    @State var number: Float = 0
    let numberTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var isIncrementing = true
    
    struct AnimationValues {
        var position = CGPoint(x: 0, y: 0)
        var scale = 1.0
        var opacity = 0.0
    }
    
    var body: some View {
        TimelineView(.animation) { context in
            layout
                .frame(maxWidth: screenSize.width)
                .dynamicTypeSize(.xSmall ... .xLarge)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 10)
                .background(.blue.opacity(0.001))
                .if(hasSimpleWave, transform: { view in
                    view
                        .distortionEffect(ShaderLibrary.simpleWave(.float(startDate.timeIntervalSinceNow)), maxSampleOffset: CGSize(width: 100, height: 100), isEnabled: hasSimpleWave)
                })
                .if(hasComplexWave, transform: { view in
                    view
                        .visualEffect { content, proxy in
                            content.distortionEffect(ShaderLibrary.complexWave(
                                .float(startDate.timeIntervalSinceNow),
                                .float2(proxy.size),
                                .float(0.5),
                                .float(8),
                                .float(10)
                            ), maxSampleOffset: CGSize(width: 100, height: 100), isEnabled: hasComplexWave)
                        }
                })
                .foregroundStyle(hasSimpleWave || hasComplexWave ? .blue.opacity(0.5) : .white)
                .animation(.easeInOut(duration: 1.2), value: hasSimpleWave || hasComplexWave)
        }
        
    }// some view
    
    var layout: some View {
        ZStack {
            TimelineView(.animation) { context in
                    card.image
                        .resizable()
                        .aspectRatio(contentMode: isTapped ? .fit : .fill)
                        .frame(height: isTapped ? 500 : 550)
                        .frame(height: hasEmboss || isPixellated ? 301 : 550)
                        .frame(width: isTapped ? screenSize.width + 10 : screenSize.width - 40)
                        .if(hasNoise, transform: { view in
                            view
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .colorEffect(ShaderLibrary.noise(.float(startDate.timeIntervalSinceNow)), isEnabled: hasNoise)
                                        .blendMode(.overlay)
                                        .opacity(hasNoise ? 1 : 0)
                                        .frame(height: isTapped ? 301 : 550)
                                )
                        })
                        .if(hasEmboss, transform: { view in
                            view
                                .layerEffect(ShaderLibrary.emboss(.float(number)), maxSampleOffset: .zero, isEnabled: hasEmboss)
                            
                        })
                        .if(isPixellated, transform: { view in
                            view
                                .layerEffect(ShaderLibrary.pixellate(.float(number)), maxSampleOffset: .zero, isEnabled: isPixellated)
                        })
                        .onReceive(numberTimer) { _ in
                            guard isPixellated || hasEmboss else { return }
                            number += isIncrementing ? 1 : -1
                            if number >= 5 {
                                isIncrementing = false
                            }
                            else if number <= 0 { isIncrementing = true }
                        }
                        .overlay(
                            Text(card.title)
                                .font(.system(size: isTapped ? 40 : 20))
                                .fontWidth(isTapped ? .standard : .expanded)
                                .fontWeight(isTapped ? .heavy : .semibold)
                                .foregroundStyle(.white)
                                .opacity(isTapped ? 0.8 : 1)
                                .padding()
                                .shadow(color: .black.opacity(0.5), radius: isTapped ? 3 : 5, y: 10)
                                .frame(maxHeight: .infinity, alignment: isTapped ? .bottom : .top)
                                .offset(y: isTapped ? -110 : 0)
                                .offset(y: hasEmboss || isPixellated ? 124.2 : 0)
                        )
                        .cornerRadius(isTapped ? 0 : 20)
                        .overlay(
                            RoundedRectangle(cornerRadius: isTapped ? 0 : 20)
                                .strokeBorder(linearGradient)
                                .opacity(isTapped ? 0 : 1)
                        )
                        .offset(y: isTapped ? -160 : 0)
                        .phaseAnimator([1, 2], trigger: isTapped) { content, phase in
                            content.scaleEffect(phase == 2 ? 1.1 :  1)
                        }
                        .onTapGesture {
                            hasNoise.toggle()
                        }
                
            }
            
            Circle()
                .fill(.secondary)
                .frame(width: 80)
                .overlay(Circle().stroke(.secondary))
                .overlay(
                    Image(.picture)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40))
                .keyframeAnimator(initialValue: AnimationValues(), trigger: isDownloading) { content, value in
                    content.offset(x: value.position.x, y: value.position.y)
                        .scaleEffect(value.scale)
                        .opacity(value.opacity)
                } keyframes: { value in
                    KeyframeTrack(\.position) {
                        SpringKeyframe(CGPoint(x: 100, y: -100), duration: 0.5, spring: .bouncy)
                        CubicKeyframe(CGPoint(x: 400, y: 1000), duration: 0.5)
                    }
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(1.2, duration: 0.5)
                        CubicKeyframe(1, duration: 0.5)
                    }
                    KeyframeTrack(\.opacity) {
                        CubicKeyframe(1, duration: 0)
                    }
                }
            
            
            content
                .padding(20)
                .background(hasSimpleWave || hasComplexWave ? AnyView(Color(.secondarySystemBackground)) : AnyView(Color.clear.background(.ultraThinMaterial)))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(linearGradient)
                )
                .cornerRadius(20)
                .padding(40)
                .background(.blue.opacity(0.001))
                .offset(y: isTapped ? 220 : 160)
                .phaseAnimator([1, 1.1], trigger: isTapped) { content, phase in
                    content.scaleEffect(phase)
                } animation: { phase in
                    switch phase {
                    case 1: .bouncy
                    case 1.1: .easeOut(duration: 0.8)
                    default: .easeInOut
                    }
                }
            
            play
                .frame(width: isTapped ? 210 : 50)
                .foregroundStyle(.primary, .white)
                .font(.largeTitle)
                .padding(20)
                .background(hasSimpleWave || hasComplexWave ?
                            AnyView(Color(.secondarySystemBackground)) :
                    AnyView(Color.clear.background(.ultraThinMaterial)))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(linearGradient)
                )
                .cornerRadius(20)
                .offset(y: isTapped ? 70 : 37)
        }
    }
    
    var linearGradient: LinearGradient {
        LinearGradient(colors: [.clear, .white.opacity(0.3), .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    var content: some View {
        VStack(alignment: .center) {
            Text(card.text)
                .font(isTapped ? .headline : .subheadline)
            
            HStack {
                HStack {
                    Image(systemName: "waveform")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .symbolEffect(.bounce, options: .default, value: isActive)
                        .onTapGesture { hasSimpleWave.toggle() }
                        .padding(.trailing, 5)
                    
                    Divider()
                    
                    Image(systemName: "water.waves")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .symbolEffect(.variableColor.reversing, isActive: isActive)
                        .onTapGesture { hasComplexWave.toggle() }
                }
                .padding()
                .overlay(
                    UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 0, bottomLeading: 20, bottomTrailing: 0, topTrailing: 20))
                        .strokeBorder(linearGradient)
                )
                .offset(x: -20, y: isTapped ? 15 : 10)
                
                Spacer()
                
                Image(systemName: "square.and.arrow.down")
                    .font(.title3)
                    .padding()
                    .overlay(
                        UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 0, bottomTrailing: 20, topTrailing: 0))
                            .strokeBorder(linearGradient)
                    )
                    .offset(x: 20, y: isTapped ? 20 : 10)
                    .symbolEffect(.bounce, value: isDownloading)
                    .onTapGesture {
                        isDownloading.toggle()
                    }
            }
            .frame(height: isTapped ? 40 : 33)
        }
    }
    
    
    var play: some View {
        HStack(spacing: 25) {
            Image(.paint)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .shadow(color: .black.opacity(0.3), radius: 2, y: 4)
                .scaleEffect(isPressingEmboss ? 0.8 : 1)
                .opacity(isPressingEmboss ? 0.8 : 1)
                .opacity(isTapped ? 1 : 0)
                .blur(radius: isTapped ? 0 : 20)
                .onTapGesture {
                    hasEmboss.toggle()
                    number = 0
                    withAnimation {
                        isPressingEmboss = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isPressingEmboss = false
                        }
                    }
                }
            
            Image(isTapped ? .pause : .play)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .shadow(color: .black.opacity(0.3), radius: 2, y: 4)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        isTapped.toggle()
                        isHidden.toggle()
                        
                   
                    }
                }
            
            Image(.sparkles)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .shadow(color: .black.opacity(0.5), radius: 2, y: 4)
                .scaleEffect(isPressingPixellate ? 0.8 : 1)
                .opacity(isPressingPixellate ? 0.8 : 1)
                .opacity(isTapped ? 0.8 : 0)
                .blur(radius: isTapped ? 0 : 20)
                .onReceive(timer) { value in
                    time = value
                    isActive.toggle()
                }
                .onTapGesture {
                    isPixellated.toggle()
                    number = 0
                    withAnimation {
                        isPressingPixellate = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isPressingPixellate = false
                        }
                    }
                }
        }
        .frame(height: 55)
    }
}


#Preview {
    CardView(screenSize: .constant(CGSize(width: 393, height: 852)), isHidden: .constant(false))
}
