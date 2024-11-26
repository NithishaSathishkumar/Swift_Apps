//
//  ContentView.swift
//  NithishaCard
//
//  Created by Nithisha Sathishkumar on 8/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.white).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Image("img")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 200)
                
                    
                Text("Nithisha Sathishkumar")
                    .font(Font.custom("LibreBaskerville-Bold", size: 25))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    
                Text("Programmer")
                    .font(.title2)
                    .fontWeight(.light)
                
                Divider()
                    .padding()
                InfoView(text: "+1 425 364 0364", ImageName: "phone.fill", textSize: 20)
                InfoView(text: "nithisha.sathishkumar@gmail.com", ImageName: "envelope.fill", textSize: 17)
                InfoView(text: "www.linkedin.com/in/nithishasathishkumar", ImageName: "person.crop.rectangle", textSize: 15)
                
            
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}

struct InfoView: View {
    let text: String
    let ImageName: String
    let textSize: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: 360, height: 50)
            .foregroundColor(.accentColor)
            .padding(5)
            .overlay(HStack {
                Image(systemName: ImageName)
                    .foregroundColor(.white)
                    .padding(5)
                Text(text)
                    .font(.system(size: CGFloat(textSize)))
                    .foregroundColor(.white)
                
            })
    }
}
