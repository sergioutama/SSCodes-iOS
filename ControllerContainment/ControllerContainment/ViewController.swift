//
//  ViewController.swift
//  ControllerContainment
//
//  Created by Sergio Utama on 30/11/2016.
//  Copyright © 2016 Sergio Utama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showButton: UIButton! {
        didSet {
            showButton.addTarget(self, action: #selector(ViewController.showChildController), for: .touchUpInside)
        }
    }
    
    var theChildController : SmallViewController?
    var darkView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func showChildController() {
        
        
        let storyboard = self.storyboard
        theChildController = storyboard?.instantiateViewController(withIdentifier: "SmallViewController") as? SmallViewController
        
        theChildController!.delegate = self
        
        
        
        
        // set the frame / or use autolayout
        
        let currentFrame = view.frame
        
        darkView = UIView(frame: currentFrame)
        darkView!.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissChildController))
        darkView!.addGestureRecognizer(tapGesture)
        
        view.addSubview(darkView!)
        
        
        
        let viewFrame = CGRect(x: 20, y: 100, width: currentFrame.width - 40, height: 200)
        
        theChildController!.view.frame = viewFrame
        
        // add the viewController.view as subview
        view.addSubview(theChildController!.view)
        
    
        // tell that it's going to move to parrent
        theChildController!.willMove(toParentViewController: self)// this is the main difference compared with adding subview
        
    }
    
    func dismissChildController() {
        theChildController?.view.removeFromSuperview()
        theChildController?.removeFromParentViewController()
        darkView?.removeFromSuperview()
    }
    
}

extension ViewController : SmallViewControllerDelegate {
    
    func didPressInsideButton(controller: SmallViewController) {
        
        dismissChildController()
        
    }
}

