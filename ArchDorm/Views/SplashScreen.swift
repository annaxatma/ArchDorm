//
//  SplashScreen.swift
//  ArchDorm
//
//  Created by MacBook Pro on 31/05/22.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                Home()
            } else {
                Image("logo")
            }
        }
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
              withAnimation {
                  self.isActive = true
              }
          }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
