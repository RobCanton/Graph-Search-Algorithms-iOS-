//
//  WebViewController.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2016-02-02.
//  Copyright © 2016 Robert Canton. All rights reserved.
//

import iAd
import Foundation
import UIKit
import WebKit
import SystemConfiguration

class WebViewController: UIViewController, WKNavigationDelegate, ADBannerViewDelegate
{
    var bannerView: ADBannerView!
    var webView: WKWebView!
    var searchType:search!
    
    let urls = [
        search.DepthFirst:"https://en.wikipedia.org/wiki/Depth-first_search",
        search.BreadthFirst:"https://en.wikipedia.org/wiki/Breadth-first_search",
        search.BestFirst:"https://en.wikipedia.org/wiki/Best-first_search",
        search.AStar:"https://en.wikipedia.org/wiki/A*_search_algorithm"
    ]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() {
            let url = NSURL(string: urls[searchType]!)!
            webView.loadRequest(NSURLRequest(URL: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        else
        {
            let refreshAlert = UIAlertController(title: "Unable to load", message: "You are not connected to the internet.", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
        }
        
        bannerView = ADBannerView(adType: .Banner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.delegate = self
        bannerView.hidden = false
        view.addSubview(bannerView)
        
        let viewsDictionary = ["bannerView": bannerView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        
        
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        bannerView.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        bannerView.hidden = true
    }
}

public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}