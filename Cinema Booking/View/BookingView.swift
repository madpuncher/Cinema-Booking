//
//  BookingView.swift
//  Cinema Booking
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 05.05.2021.
//

import SwiftUI

struct BookingView: View {
    
    @State var bookedSeats: [Int] = [1,10,25,30,45,59,60]
    @State var selectedSeats: [Int] = []
    
    @State var date: Date = Date()
    
    @State var selectedTime = "11:30"
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            HStack {
                
                Button(action: {
                    
                }){
                    
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .overlay(
                
                Text("Забронировать места")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            )
            .padding()
            
            
            GeometryReader { reader in
                
                let width = reader.frame(in: .global).width
                Path { path in
                    
                    path.move(to: CGPoint(x: 0, y: 50))
                    
                    path.addCurve(to: CGPoint(x: width, y: 50), control1: CGPoint(x: width / 2, y: 0), control2: CGPoint(x: width / 2, y: 0))
                }
                .stroke(Color.gray, lineWidth: 1.5)
            }
            .frame(height: 5)
            .padding(.top, 20)
            .padding(.horizontal, 35)
            
            let totalSeats = 60 + 4
            
            let leftSide = 0..<totalSeats/2
            let rightSide = totalSeats/2..<totalSeats
            
            HStack(spacing: 30) {
                
                let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
                
                LazyVGrid(columns: columns, spacing: 13) {
                    
                    ForEach(leftSide, id: \.self) { index in
                        
                        let seat = index >= 29 ? index - 1 : index
                        
                        SeatView(index: index, seat: seat, selectedSeats: $selectedSeats, bookedSeats: $bookedSeats)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                
                                if selectedSeats.contains(seat) {
                                    
                                    selectedSeats.removeAll { (removeSeat) -> Bool in
                                        
                                        return removeSeat == seat
                                    }
                                    
                                    return
                                }
                                
                                selectedSeats.append(seat)
                            }
                            .disabled(bookedSeats.contains(seat))
                    }
                }
                
                LazyVGrid(columns: columns, spacing: 13) {
                    
                    ForEach(rightSide, id: \.self) { index in
                        
                        let seat = index >= 35 ? index - 2 : index - 1
                        
                        SeatView(index: index, seat: seat, selectedSeats: $selectedSeats, bookedSeats: $bookedSeats)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                
                                if selectedSeats.contains(seat) {
                                    
                                    selectedSeats.removeAll { (removeSeat) -> Bool in
                                        
                                        return removeSeat == seat
                                    }
                                    
                                    return
                                }
                                
                                selectedSeats.append(seat)
                            }
                            .disabled(bookedSeats.contains(seat))
                    }
                }
            }
            .padding()
            .padding(.top, 30)
            
            HStack(spacing: 15) {
                
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray)
                    .frame(width: 20, height: 20)
                    .overlay(
                    
                        Image(systemName: "xmark")
                            .font(.caption)
                            .foregroundColor(.gray)
                    )
                
                Text("Занятые")
                    .font(.caption)
                    .foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color("button"), lineWidth: 2)
                    .frame(width: 20, height: 20)
                
                Text("Доступные")
                    .font(.caption)
                    .foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color("button"))
                    .frame(width: 20, height: 20)
                
                Text("Выбранные")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(.top, 25)
            
            HStack {
                
                Text("Дата:")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 15) {
                    
                    ForEach(time, id: \.self) { timing in
                        
                        Text(timing)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal, 20)
                            .background(Color("button").opacity(selectedTime == timing ? 1 : 0.2))
                            .cornerRadius(10)
                            .onTapGesture {
                                
                                selectedTime = timing
                            }
                    }
                }
                .padding(.horizontal)
            }
            
            HStack(spacing: 15) {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("\(selectedSeats.count) Мест")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("₽\(selectedSeats.count * 300)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                }
                .frame(width: 100)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    
                    Text("Купить билеты")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("button"))
                        .cornerRadius(15)
                }
            }
            .padding()
            .padding(.top, 20)
        }
        .background(Color("bg").ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}

struct SeatView: View {
    
    var index: Int
    var seat: Int
    
    @Binding var selectedSeats: [Int]
    @Binding var bookedSeats: [Int]
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 6)
                .stroke(bookedSeats.contains(seat) ? Color.gray : Color("button"), lineWidth: 2)
                .frame(height: 30)
                .background(
                
                    selectedSeats.contains(seat) ? Color("button") : Color.clear
                )
                .opacity(index == 0 || index == 28 || index == 35 || index == 63 ? 0 : 1)
            
            if bookedSeats.contains(seat) {
                
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            }
        }
    }
}
