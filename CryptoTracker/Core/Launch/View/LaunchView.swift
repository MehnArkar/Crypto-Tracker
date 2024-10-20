//
//  LaunchView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 20/10/2024.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText : [String] = "Loading your portfolio...".map{ String($0) }
    @State private var showLoadingText : Bool = false
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State private var counter : Int = 0
    @State private var loopCount : Int = 0
    @Binding var showLaunchView : Bool
    
    var body: some View {
        ZStack{
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .scaledToFit()
                .frame(width: 100, height: 100)
            if showLoadingText{
                ZStack{
                    HStack(spacing: 0){
                        ForEach( loadingText.indices ){ index in
                            
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(.launchAccent)
                                .offset(y: index == counter ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition(.scale))
                }
                .offset(y: 70)
            }
            
        }
        .onAppear{
            showLoadingText.toggle()
        }
        .onReceive(timer){ _ in
            let lastIndex = loadingText.count - 1
            if counter==lastIndex {
                counter = 0
                
                loopCount += 1
                
                if loopCount >= 2 {
                    showLaunchView.toggle()
                }
            }else {
                counter += 1
            }
            
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
