//
//  ViewController.swift
//  volxbibel_swift
//
//  Created by Simon Brüchner on 04.07.17.
//  Copyright © 2017 Brüchner IT Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    
    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = UIWebView(frame: UIScreen.main.bounds)
        webView.delegate = self
        view.addSubview(webView)
        
        do {
            guard let filePath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "www")
            else {
                print ("File error")
                return
            }
        
            let contents    =  try String(contentsOfFile: filePath, encoding: .ascii)
            let baseUrl     = URL(fileURLWithPath: filePath)
            
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
        } catch {
            print ("HTML error")
        }
    }
    
    /**
     * Statusbar ausblenden
     */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    /**
     * Externe URLs im Mobile Safari laden.
     */
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.linkClicked {
            UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
            return false
        }
        return true
    }
}
