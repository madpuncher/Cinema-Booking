//
//  ContentView.swift
//  Cinema Booking
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 05.05.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            
            Home()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

