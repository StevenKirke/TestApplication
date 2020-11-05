//
//  ContentViewModel.swift
//  TestApplication
//
//  Created by JARVIS on 03.11.2020.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
        
    let networkDataFetcher = NetworkDataFetcher()
    var cancellable: AnyCancellable?
    @Published var authors = [Author]()
    @Published var searchText = ""
    
    init() {
        cancellable = AnyCancellable($searchText
                                        .removeDuplicates()
                                        .debounce(for: 1, scheduler: DispatchQueue.main)
                                        .sink(receiveValue: { ( search ) in
                                            self.request(search: search)
                                        })
        )
    }
    
    func request(search: String) {
        networkDataFetcher.fetcherAuthor(lastName: search) { (result) in
            switch result {
            case .none:
                self.authors =  []
            case .some(let authors):
                print(authors)
                self.authors = authors.author ?? []
            }
        }
    }
}
