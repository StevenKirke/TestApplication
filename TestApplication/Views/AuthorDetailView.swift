//
//  AuthorDetailView.swift
//  TestApplication
//
//  Created by JARVIS on 02.11.2020.
//

import SwiftUI

struct AuthorDetailView: View {
    let author: String
    var body: some View {
        Text(author)
    }
}

struct AuthorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorDetailView(author: "")
    }
}
