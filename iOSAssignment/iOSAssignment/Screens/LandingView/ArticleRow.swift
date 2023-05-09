//
//  ArticleRow.swift
//  iOSAssignment
//
//  Created by MUhammad Sadiq on 08/05/2023.
//

import SwiftUI

struct ArticleRow: View {
    
    var article: Article?
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack() {
                if let imageUrl = URL(string: article?.media?.first?.mediaMetadata?.last?.url ?? "") {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .cornerRadius(5)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }
                VStack(alignment: .leading) {
                    Spacer()
                    CustomText(color: .secondaryColor, fontSize: 16, weight: .bold, line: 3, text: article?.title ?? "Title")
                    Spacer(minLength: 2)
                    CustomText(color: .grayColor, fontSize: 14, weight: .regular, line: 3, text: article?.byline ?? "Subtitle")
                    Spacer(minLength: 4)

                }.padding(.leading, 5)
            }
            HStack() {
                Spacer()
                CustomText(color: .grayColor, fontSize: 14, weight: .regular, line: 1, text: article?.published_date ?? "DateTime")
            }
        }
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: nil)
    }
}
