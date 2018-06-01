//
//  SmallViewController.swift
//  ControllerContainment
//
//  Created by Sergio Utama on 30/11/2016.
//  Copyright © 2016 Sergio Utama. All rights reserved.
//

import UIKit

// set custom delegate
protocol SmallViewControllerDelegate {
    func didPressInsideButton(controller: SmallViewController)
}

class SmallViewController: UIViewController {

    // set button
    @IBOutlet weak var buttonInside: UIButton! {
        didSet {
            buttonInside.addTarget(self, action: #selector(SmallViewController.buttonPressed), for: .touchUpInside)
        }
    }
    
    var delegate : SmallViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }

    // function when button pressed
    func buttonPressed() {
        
        // call the delegate
        delegate?.didPressInsideButton(controller: self)
    }

}
