//
//  Background.swift
//  WetherApp
//
//  Created by Blur on 2/30/1401 AP.
//

import SwiftUI

struct Background: View {
    //MARK: -PROPERTIES
    @State private var randomCircle = Int.random(in: 12...16)
    @State private var isAnimating : Bool = false
    let images:[String] = ["6","7","8","9","10","11"]
    //MARK: -FUNCTION
    
    //1. RANDOM CORDINATE
    func randomCordinate(max: CGFloat)-> CGFloat{
        return CGFloat.random(in: 0...max)
    }
    //2. RANDOM SIZE
    func randomSize() -> CGFloat{
        return CGFloat(Int.random(in: 10...300))
    }
    
    //3. RANDOM SCALE
    func randomScale()-> CGFloat{
        return CGFloat(Double.random(in: 0.1...2.0))
    }
    
    //4. RANDOM SPEED
    func randomSpeed()-> Double{
        return Double.random(in: 0.025...1.0)
    }
    //5. RANDOM DELAY
    func randomDelay()->Double{
        return Double.random(in: 0...2)
    }
    //MARK: -BODY
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(images , id: \.self){ item in
                    Image(item)
                        .opacity(0.15)
                        .frame(width: randomSize() , height: randomSize(), alignment: .center)
                        .scaleEffect( isAnimating ? randomScale() : 1)
                        .position(
                            x: randomCordinate(max: geometry.size.width) ,
                            y: randomCordinate(max: geometry.size.height)
                        )
                        .animation(
                            Animation.interpolatingSpring(stiffness: 0.5, damping: 0.5)
                                .repeatForever()
                                .speed(randomSpeed())
                                .delay(randomDelay())
                        )
                        .onAppear {
                            isAnimating = true
                        }
                }
            }
            .background(.blue)
            .drawingGroup()
        }   .ignoresSafeArea()
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
