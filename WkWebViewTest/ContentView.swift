//
//  ContentView.swift
//  WkWebViewTest
//
//  Created by Jan Ole Suhr on 07.09.20.
//  Copyright © 2020 Jan Ole Suhr. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Webview(url: "https://test.whatever.com/pkmsoidc?iss=adfs")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
