//
//  Webview.swift
//  WkWebViewTest
//
//  Created by Jan Ole Suhr on 07.09.20.
//  Copyright © 2020 Jan Ole Suhr. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

// FROM:
// https://stackoverflow.com/questions/33156567/getting-all-cookies-from-wkwebview
extension WKWebView
{
    private var httpCookieStore: WKHTTPCookieStore
    {
        return WKWebsiteDataStore.default().httpCookieStore
    }

    func getCookies(for domain: String? = nil, completion: @escaping ([String : Any])->())
    {
        var cookieDict = [String : AnyObject]()
     
        httpCookieStore.getAllCookies
        {
            cookies in
            
            for cookie in cookies
            {
                if let domain = domain
                {
                    if cookie.domain.contains(domain)
                    {
                        cookieDict[cookie.name] = cookie.properties as AnyObject?
                    }
                }
                else
                {
                    cookieDict[cookie.name] = cookie.properties as AnyObject?
                }
            }

            completion(cookieDict)
        }
    }
}

// FROM:
// https://www.youtube.com/watch?v=C5xxrCj8LC0
struct Webview: UIViewRepresentable
{
    var wkWebView: WKWebView = WKWebView();
    var url: String;
    
    func makeUIView(context: Context) -> WKWebView
    {
        // spoof user agent header ...
        self.wkWebView.customUserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"

        guard let url = URL(string: self.url) else {
            return wkWebView
        }
    
        let request = URLRequest(url: url)
        wkWebView.load(request)

        return wkWebView
    }

    func updateUIView(_ uiView: UIViewType, context: Context)
    {
        // just print all the cookies everytime the Webview changes ...
        
        self.wkWebView.getCookies()
        {
            data in
            
            print("=========================================")
            print(data)
        }
    }
}
