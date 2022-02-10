//
//  Splash.swift
//  TaskManagement
//
//  Created by Roman Fedotov on 23.01.2022.
//

import SwiftUI

struct Splash: View {
    
    @State var animationValues: [Bool] = Array(repeating: false, count: 10)
    
    var body: some View {
        
        ZStack {
            
            GeometryReader { reader in
                
                let size = reader.size
                
                OnBoarding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .offset(y: animationValues[2] ? 0 : (size.height + 50))
            }
            
            if !animationValues[3] {
                ZStack {
                    
                    Triangle()
                        .rotation(Angle(degrees: 150))
                        .fill(LinearGradient(gradient: .init(colors: [
                            Color(UIColor(red: 0, green: 0.608, blue: 0.875, alpha: 1).cgColor),
                            Color(UIColor(red: 0, green: 0.663, blue: 0.588, alpha: 1).cgColor),
                            Color(UIColor(red: 0, green: 0.637, blue: 0.566, alpha: 1).cgColor)
                        ]), startPoint: .init(x: 0.25, y: 0.5), endPoint: .init(x: 0.75, y: 0.5)))
                        .frame(width: 220, height: 220, alignment: .center)
                        .aspectRatio(1.0, contentMode: .fit)
                        .position(x: UIScreen.main.bounds.width/2 + 32, y: UIScreen.main.bounds.height/2 - 5)
                        .scaleEffect(animationValues[0] ? 1 : 0)
                        .rotationEffect(Angle(degrees: animationValues[1] ? 360 : 0))
                        .scaleEffect(animationValues[2] ? 10 : 1)
                    
                    VStack {
                        Text("Time Keeper")
                            .foregroundColor(.white)
                            .font(.custom(FontFamily.russianRailGProBold, size: 18))
                        Text("Your time planner")
                            .foregroundColor(.white)
                            .font(.custom(FontFamily.russianRailGProBold, size: 12))
                    }
                    .scaleEffect(animationValues[0] ? 1 : 0)
                    .scaleEffect(animationValues[2] ? 2 : 1)
                    
                }
                .opacity(animationValues[2] ? 0 : 1)
                .environment(\.colorScheme, .light)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                animationValues[0] = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
                    animationValues[1] = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                
                withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
                    animationValues[2] = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    animationValues[3] = true
                }
            }
        }
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let point1 = CGPoint(x: rect.minX, y: rect.maxY)
        let point2 = CGPoint(x: rect.maxX, y: rect.maxY)
        let point3 = CGPoint(x: rect.midX, y: rect.minY)
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: 30)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addArc(tangent1End: point2, tangent2End: point3, radius: 30)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addArc(tangent1End: point3, tangent2End: point1, radius: 30)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}
