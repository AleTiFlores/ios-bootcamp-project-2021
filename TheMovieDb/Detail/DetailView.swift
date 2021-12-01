//
//  DetailView.swift
//  TheMovieDb
//
//  Created by Alex on 30/11/21.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    var poster: String?
    var description: String?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                    KFImage(URL(string: "\(MovieDbEndPoints.imagesBaseURL)\(poster ?? "")"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 400)
                    Spacer()
                }
                .offset(y: -20)
            
                Text(description ?? "")
                    .font(.body)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding()
            .padding(.horizontal)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(poster: "opPoster", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    }
}
