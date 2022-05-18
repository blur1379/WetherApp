//
//  ContentView.swift
//  WetherApp
//
//  Created by Blur on 2/22/1401 AP.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Search()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.ignoresSafeArea()
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
