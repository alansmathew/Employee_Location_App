//
//  LoadingAnimation.swift
//  Employee_Location_App
//
//  Created by Alan S Mathew on 12/05/21.
//

import SwiftUI

struct LoadingAnimation: View {
    
    // MARK:- variables
//    @State var circleEnd: CGFloat = 0.001
    @State var smallerCircleEnd: CGFloat = 1
    
    @State var smallerRotationDegree: Angle = Angle.degrees(-30)
    
    let trackerRotation: Double = 1
    let animationDuration: Double = 1.35
    
    // MARK:- views
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
                Circle()
                    .trim(from: 0, to: smallerCircleEnd)
                    .stroke(style: StrokeStyle(lineWidth: 18, lineCap: .round))
                                        .fill(Color.gray.opacity(0.9))
                    .rotationEffect(self.smallerRotationDegree)
                    .frame(width: 48, height: 48 )
            .onAppear() {
                animate()
                Timer.scheduledTimer(withTimeInterval: animationDuration * 1.98, repeats: true) { _ in
                    reset()
                    animate()
                }
            }
        }
    }
    
    // MARK:- functions
    func animate() {
        
        withAnimation(Animation.easeOut(duration: animationDuration * 0.85)) {
            self.smallerCircleEnd = 0.001
            self.smallerRotationDegree = RotationDegrees.initialSmallCircle.getRotationDegrees()
        }
        

        Timer.scheduledTimer(withTimeInterval: animationDuration * 0.7, repeats: false) { _ in
            withAnimation(Animation.easeIn(duration: animationDuration * 0.4)) {
                self.smallerRotationDegree = RotationDegrees.middleSmallCircle.getRotationDegrees()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(Animation.easeOut(duration: animationDuration)) {}
            
            withAnimation(Animation.linear(duration: animationDuration * 0.8)) {
                self.smallerCircleEnd = 1
                self.smallerRotationDegree = RotationDegrees.last.getRotationDegrees()
            }
        }
    }
    
    func reset() {
        self.smallerRotationDegree = Angle.degrees(-30)
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LoadingAnimation()
        }
    }
}


enum RotationDegrees {
    case initialCicle
    case initialSmallCircle
    
    case middleCircle
    case middleSmallCircle
    
    case last
    
    func getRotationDegrees() -> Angle {
        switch self {
        case .initialCicle:
            return .degrees(365)
        case .initialSmallCircle:
            return .degrees(679)
            
        case .middleCircle:
            return .degrees(375)
        case .middleSmallCircle:
            return .degrees(825)
            
        case .last:
            return .degrees(990)
        }
    }
}
