//
//  AuthorDetailView.swift
//  TestApplication
//
//  Created by JARVIS on 02.11.2020.
//

import SwiftUI

struct AuthorDetailView: View {
    let author: Author
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            Text(author.authordisplay ?? "")
            Text(author.authorlastfirst ?? "")
            Text(author.spotlight?.htmlToString ?? "")
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding()
    }
}
