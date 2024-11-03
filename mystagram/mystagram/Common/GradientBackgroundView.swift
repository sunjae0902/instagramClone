//
//  GradientBackgroundView.swift
//  mystagram
//
//  Created by sunjae on 11/3/24.
//

import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: .gradientYellow, location: 0.1),
                Gradient.Stop(color: .gradientRed, location: 0.3),
                Gradient.Stop(color: .gradientBlue, location: 0.6),
                Gradient.Stop(color: .gradientGreen, location: 1)
            ], startPoint: .topLeading, endPoint: .bottomTrailing
        ).ignoresSafeArea()
    }
}
