//
//  ContentView.swift
//  TestApplication
//
//  Created by JARVIS on 02.11.2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(text: $viewModel.searchText, action: { changeText() }, buttonAction: { changeText() } )
                //.padding(.leading, )
                ForEach (viewModel.authors) { author in
                    if let name = author.authordisplay {
                        Text(name)
                            .background(NavigationLink("", destination: AuthorDetailView(author: author)))
                    }
                }
            }
            .navigationBarTitle(Text("Author"), displayMode: .inline)
        }
        .onAppear(perform: {
            viewModel.request(search: "")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    func changeText() {
        viewModel.request(search: "")
    }
}
