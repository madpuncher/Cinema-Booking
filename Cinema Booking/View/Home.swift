//
//  Home.swift
//  Cinema Booking
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 05.05.2021.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack(spacing: 15, pinnedViews: [.sectionFooters]) {
                
                Section(footer: FooterView()) {
                    
                    HStack {
                        
                        Button(action: {}) {
                            
                            Image(systemName: "chevron.left")
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            
                            Image(systemName: "bookmark")
                                .font(.title2)
                        }
                        
                    }
                        .overlay(
                            Text("Детали фильма")
                                .font(.title2)
                                .fontWeight(.semibold)
                        )
                    .padding()
                    .foregroundColor(.white)
                    
                    ZStack {
                        
                        // Bottom shadow...
                        
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.2))
                            .padding(.horizontal)
                            .offset(y: 12)
                        
                        Image("poster")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(15)
                    }
                    .frame(width: getRect().width / 1.5, height: getRect().height / 2)
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Гнев человеческий")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Режисёр: Гай Ричи | 4")
                            .foregroundColor(.white)
                            .overlay(
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .offset(x: 35, y: -2)
                                ,alignment: .trailing
                            )
                        
                        //Generes...
                
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], alignment: .leading) {
                       
                            ForEach(genre, id: \.self) { genreText in
                                
                                Text(genreText)
                                    .font(.caption)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(Color.white.opacity(0.08))
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.top, 20)
                        
                        Text("Описание")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                        
                        Text(synopsis)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 55)
                    .padding(.horizontal)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .background(Color("bg").ignoresSafeArea())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// extending view to get rect

extension View {
    
    func getRect() -> CGRect {
        
        return UIScreen.main.bounds
    }
}

struct FooterView: View {
    
    var body: some View {
        
        NavigationLink(
            destination: BookingView()) {
            
            Text("Купить билеты")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(width: getRect().width / 2)
                .background(Color("button"))
                .cornerRadius(15)
        }
        .shadow(color: Color.white.opacity(0.15), radius: 5, x: 5, y: 5)
        .shadow(color: Color.white.opacity(0.15), radius: 5, x: -5, y: -5)
    }
}
