//
//  CustomText.swift
//  iOSAssignment
//
//  Created by MUhammad Sadiq on 08/05/2023.
//

import SwiftUI

struct CustomText: View {
    var color: Color = .black
    var fontSize = 14.0
    var weight : Font.Weight = .regular
    var line: Int = 1
    var text: String = "Hello World"
    
    var body: some View {
        if line == 0 {
            Text(text)
                .foregroundColor(color)
                .font(.system(size: fontSize, weight: weight, design: .default))
        }
        else {
            Text(text)
                .foregroundColor(color)
                .lineLimit(line)
                .font(.system(size: fontSize, weight: weight, design: .default))
        }
    }
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText()
    }
}
