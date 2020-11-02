//
//  ContentView.swift
//  TestApplication
//
//  Created by JARVIS on 02.11.2020.
//

import SwiftUI

class ContentViewModel: ObservableObject {
        
    @Published var autors = [Author]()
    let servise = AuthorsGetService()
    
    func request(search: String) {
        servise.get(firstName: nil, lastName: search) { (result) in
            switch result {
            case .success(let authors):
                print(authors)
                self.autors = authors.author ?? []
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State private var searchText = ""
    let array = ["Peter", "Paul", "Mary", "Anna-Lena", "George",
                         "John", "Greg", "Thomas", "Robert", "Bernie", "Mike",
                         "Benno", "Hugo", "Miles", "Michael", "Mikel", "Tim",
                         "Tom", "Lottie", "Lorrie", "Barbara", "Lottie", "Lorrie", "Barbara"]
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(text: $searchText)
                    //.padding(.leading, )
                ForEach(array, id: \.self) { elem in
                    Text(elem)
                        .background(NavigationLink("", destination: AuthorDetailView(author: elem)))
                }
            }
            .navigationBarTitle(Text("Author"), displayMode: .inline)
        }
    }
}
            /*
            VStack {
                SearchBar(text: $searchText)
                    .padding(.top, 30)
                List {
                    ForEach(array, id: \.self) { element in
                        if let name = element {
                            Text(name)
                                .background(NavigationLink("", destination: AuthorDetailView(author: name)))
                        }
                    }
                    /*
                    ForEach(array) { author in
                        if let name = author.authorfirst {
                            Text(name)
                                .background(NavigationLink("", destination: AuthorDetailView(author: name)))
                        }
                    }
                    */
                }
                .navigationBarTitle(Text("Author"), displayMode: .inline)
            }
        }
        .onAppear(perform: {
            viewModel.request(search: searchText)
        })
             */


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 TextField("", text: $searchText, onEditingChanged: { (_) in
     print("1")
 }, onCommit: {
     viewModel.request(search: searchText)
 })
 */
