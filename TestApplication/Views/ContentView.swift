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
    @State var search: String = "fdsf"
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $search, onEditingChanged: { (_) in
                    print("1")
                }, onCommit: {
                    viewModel.request(search: search)
                })
                List {
                    ForEach(viewModel.autors) { author in
                        if let name  = author.authorfirst {
                            Text(name)
                        }

                    }
                }
                .navigationBarTitle(Text("Author"), displayMode: .inline)
            }
        }
        .onAppear(perform: {
            viewModel.request(search: search)
        })
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 struct ElementTextField: View {
     @Binding var name: String
     var body: some View {
         TextField("Enter name", text: $name)
             .padding(.leading)
             .accentColor(.white)
             .foregroundColor(.white)
             .frame(width: 280, height: 40, alignment: .center)
             .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3058823529, green: 0.3137254902, blue: 0.3490196078, alpha: 1)), Color(#colorLiteral(red: 0.4156862745, green: 0.4235294118, blue: 0.4431372549, alpha: 1))]),
                                        startPoint: .trailing,
                                        endPoint: .leading)
             .cornerRadius(10)
             .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
         )
     }
 }

 struct ElementTextField_Previews: PreviewProvider {
     static var previews: some View {
         StatefulPreviewWrapper("ss") { ElementTextField(name: $0) }
     }
 }
 */
