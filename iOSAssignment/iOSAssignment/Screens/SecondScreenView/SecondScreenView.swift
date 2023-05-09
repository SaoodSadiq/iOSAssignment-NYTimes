//
//  SecondScreenView.swift
//  iOSAssignment
//
//  Created by MUhammad Sadiq on 08/05/2023.
//

import SwiftUI

struct SecondScreenView: View {
    var article: Article?
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: article?.media?.first?.mediaMetadata?.last?.url ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight:200)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                //.frame(width: 300, height: 300)
                .background(Color.gray)
                HStack() {
                    Spacer()
                    CustomText(color: .secondaryColor, fontSize: 14, weight: .regular, line: 1, text: article?.published_date ?? "")
                        //.background(Color.gray)
                }
               
                Spacer(minLength: 10)
                CustomText(color: .secondaryColor, fontSize: 16, weight: .bold, line: 0, text: article?.title ?? "")
                
                Spacer(minLength: 10)
                CustomText(color: .grayColor, fontSize: 14, weight: .regular, line: 0, text: article?.abstract ?? "")
                
                Spacer(minLength: 10)
                HStack() {
                    CustomText(color: .secondaryColor, fontSize: 14, weight: .regular, line: 0, text: "ByLine :  ")
                    CustomText(color: .grayColor, fontSize: 14, weight: .regular, line: 0, text: article?.byline ?? "")
                }
                Spacer(minLength: 10)
                HStack() {
                    CustomText(color: .secondaryColor, fontSize: 14, weight: .regular, line: 0, text: "Source :  ")
                    CustomText(color: .grayColor, fontSize: 14, weight: .regular, line: 0, text: article?.source ?? "")
                }
            }
            .padding(.all, 10)
        }
        .background(Color.primaryColor)
    }
}

struct SecondScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreenView()
    }
}
