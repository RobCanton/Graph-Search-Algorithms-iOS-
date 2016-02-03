//
//  GameViewController.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-19.
//  Copyright (c) 2015 Robert Canton. All rights reserved.
//
import iAd
import UIKit
import SpriteKit

class GameViewController: UIViewController, ADBannerViewDelegate {
    
    let searchTypes = ["Depth First Search", "Breadth First Search", "Best First Search", "A Star Search"]
    var bannerView: ADBannerView!
    
    @IBAction func handleTitleButton(sender:UIButton!)
    {
        let ac = UIAlertController(title: "Select Search Type", message: nil, preferredStyle: .ActionSheet)
        ac.popoverPresentationController?.sourceView = sender
        for type in searchTypes {
            ac.addAction(UIAlertAction(title: type, style: .Default, handler: selectType))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    @IBAction func handleInfoButtion(sender:UIBarButtonItem!)
    {
        let skView = view as! SKView
        let gameScene = skView.scene as! GameScene
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("InfoViewController") as! WebViewController
        controller.searchType = gameScene.searchType
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBOutlet weak var navTitle:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit
            scene.size = skView.bounds.size
            
            skView.presentScene(scene)
            
        }
        
        
        bannerView = ADBannerView(adType: .Banner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.delegate = self
        bannerView.hidden = false
        view.addSubview(bannerView)
        
        let viewsDictionary = ["bannerView": bannerView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
    }
    
    
    func selectType(action: UIAlertAction!) {
        
        let skView = view as! SKView
        let gameScene = skView.scene as! GameScene
        gameScene.setSearchType(action.title!)
        navTitle.setTitle(action.title!, forState: UIControlState.Normal)
        //navTitle.titleLabel!.textAlignment = .Center
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        bannerView.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        bannerView.hidden = true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toSettings" {
            let nav = segue.destinationViewController as! UINavigationController
            let vc = nav.viewControllers[0] as! SettingsViewController
            let skView = view as! SKView
            let gameScene = skView.scene as! GameScene
            vc.gridDelegate = gameScene
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    }
