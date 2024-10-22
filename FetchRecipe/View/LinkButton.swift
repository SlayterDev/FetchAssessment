//
//  LinkButton.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import SwiftUI

enum ButtonType {
    case youtube
    case recipeLink
}

struct LinkButtonStyle: ButtonStyle {

    let type: ButtonType

    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = type == .youtube
            ? Color("YoutubeButton")
            : Color("LinkButton")

        configuration.label
            .font(.headline)
            .padding(.vertical, 11)
            .background(backgroundColor)
            .foregroundStyle(.white)
            .cornerRadius(12)
    }
}

struct LinkButton: View {

    let type: ButtonType
    let url: URL

    var body: some View {
        Button {
            UIApplication.shared.open(url)
        } label: {
            HStack {
                Image(systemName: type == .youtube ? "video" : "link")

                Text(type == .youtube ? "Youtube" : "Recipe")
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(LinkButtonStyle(type: type))
    }
}

#Preview {
    HStack {
        LinkButton(type: .youtube, url: URL(string: "https://www.youtube.com/")!)
        LinkButton(type: .recipeLink, url: URL(string: "https://www.youtube.com/")!)
    }
    .padding()
}