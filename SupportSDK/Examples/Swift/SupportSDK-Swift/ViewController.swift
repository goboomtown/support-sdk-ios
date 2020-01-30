//
//  ViewController.swift
//  SupportSDK-Swift
//
//  Created by Larry Borsato on 2019-09-17.
//  Copyright © 2019 Boomtown. All rights reserved.
//

import UIKit
import SupportSDK

class ViewController: UIViewController, SupportButtonDelegate {
   
    lazy var supportButton: SupportButton = {
        [unowned self] in
        
        let buttonSize = 75
        let buttonFrame = CGRect.init(x: 0,
                                      y: 0,
                                      width: buttonSize,
                                      height: buttonSize)
        let button = SupportButton(frame: buttonFrame)
        button.delegate = self;

        if button.loadConfigurationFile("CONFIGURATION FILE NAME", customerId: nil) == false  {
            NSLog("Unable to load configuration file")
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Support SDK Demo"
        
        view.addSubview(supportButton)
        var frame = supportButton.frame
        frame.origin.x = (self.view.frame.size.width-frame.size.width)/2
        frame.origin.y = (self.view.frame.size.height-frame.size.width)/2
        supportButton.frame = frame
        
        supportButton.advertiseService(withPublicData: ["test": "data"], privateData: ["test": "private data"])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }


    func supportButton(_ supportButton: SupportButton, displayIssueViewController viewController: UIViewController) {
        show(viewController, sender: supportButton)
    }
    
    func supportButton(_ supportButton: SupportButton, displaySupportMenu alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = supportButton
            popoverController.sourceRect = supportButton.bounds
        }
    }
    
    func supportButton(_ supportButton: SupportButton, didFailWithError error: Error) {
        NSLog("%@", error.localizedDescription)
    }
    
    func supportButton(_ supportButton: SupportButton, didAdvertiseService netService: NetService) {
            NSLog("mDNS service successfully advertised.");
    }
    
    func support(_ supportButton: SupportButton, didFailToAdvertiseService errorDict: [String : NSNumber]) {
        NSLog("mDNS service failed to advertise.");
    }

}

