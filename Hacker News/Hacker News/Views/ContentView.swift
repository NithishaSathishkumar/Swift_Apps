//
//  ContentView.swift
//  Hacker News
//
//  Created by Nithisha Sathishkumar on 8/6/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    var body: some View {
        NavigationView{
            List(networkManager.posts){ post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
            }
            .navigationTitle("Hacker News")
        }
        .onAppear{
            self.networkManager.fetchData()
        }
    }
}

#Preview {
    ContentView()
}

//let posts = [
//    Post(id: "1", title: "News 1"),
//    Post(id: "2", title: "News 2")
//]
