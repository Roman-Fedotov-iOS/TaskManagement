//
//  OnBoarding.swift
//  TaskManagement
//
//  Created by Roman Fedotov on 23.01.2022.
//

import SwiftUI

struct OnBoarding: View {
    
    @State var offset: CGFloat = 0
    
    @State private var isPresented = false
    
    var body: some View {
        
        OffsetPageTab(offset: $offset) {
            
            HStack(spacing: 0) {
                
                ForEach(onBoardingSlides) { slide in
                    
                    VStack(spacing: 15) {
                        
                        Image(slide.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: getScreenBounds().width - 100, height: getScreenBounds().width - 100)
                            .offset(y: -165)
                            .scaleEffect(getScreenBounds().height < 750 ? 0.9 : 1)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text(slide.title)
                                .font(.custom(FontFamily.russianRailGProBold, size: 26))
                                .foregroundColor(Color.white)
                            
                            Text(slide.description)
                                .font(.custom(FontFamily.russianRailGProBold, size: 18))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        }
                        .offset(y: -70)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .frame(width: getScreenBounds().width)
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .background(
        RoundedRectangle(cornerRadius: 50)
            .fill(.white)
            .frame(width: getScreenBounds().width - 100, height: getScreenBounds().width - 100)
            .scaleEffect(2)
            .rotationEffect(.init(degrees: 25))
            .rotationEffect(.init(degrees: getRotation()))
            .offset(y: -getScreenBounds().width + 20)
        
        ,alignment: .leading
        )
        .background(Color("screen\(getIndex() + 1)")
                        .animation(.easeInOut, value: getIndex())
        )
        .ignoresSafeArea(.container, edges: .all)
        .overlay(
        
            VStack {
                
                HStack(spacing: 25) {
                    
                    HStack {
                        
                        Button {
                            
                            self.isPresented.toggle()
                            
                        }
                    label: {
                            Text("Skip")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        }
                    .fullScreenCover(isPresented: $isPresented, content: Home.init)
                        
                        HStack(spacing: 8) {
                            
                            ForEach(onBoardingSlides.indices, id: \.self) { index in
                                
                                Circle()
                                    .fill(.white)
                                    .opacity(index == getIndex() ? 1 : 0.5)
                                    .frame(width: 8, height: 8)
                                    .scaleEffect(index == (getIndex()) ? 1.3 : 0.85)
                                    .animation(.easeInOut, value: getIndex())
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            
                            offset = min(offset + getScreenBounds().width, getScreenBounds().width * 3)
                            
                            var progress = getIndex()
                            
                            if progress == onBoardingSlides.count - 1 {
                                self.isPresented.toggle()
                            } else {
                                progress += 1
                            }
                        } label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        }
                        .fullScreenCover(isPresented: $isPresented, content: Home.init)
                    }
                }
                .padding(.horizontal, 10)
            }
                .padding()
            ,alignment: .bottom
        )
    }
    
    func getRotation() -> Double {
        
        let progress = offset / (getScreenBounds().width * 4)
        
        let rotation = Double(progress) * 360
        
        return rotation
    }
    
    func getIndex() -> Int {
        
        let progress = (offset / getScreenBounds().width).rounded()
        
        return Int(progress)
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}

extension View {
    func getScreenBounds() -> CGRect {
        UIScreen.main.bounds
    }
}
