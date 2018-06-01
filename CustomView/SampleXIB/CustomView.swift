//
//  CustomView.swift
//  SampleXIB
//
//  Created by Sergio Utama on 02/12/2016.
//  Copyright © 2016 Sergio Utama. All rights reserved.
//

import UIKit

class CustomView: UIView {

    
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    let button : UIButton = UIButton()
    
    private var xibContainer : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        
        // load from xib
        xibContainer = loadFromXib()
        
        addSubview(xibContainer)
        
        // auto layout
        xibContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let dictionaryViews: [String: UIView] = ["view":xibContainer]
        
        // set constraint on left and right
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", metrics: nil, views: dictionaryViews))
        
        // set constraint on top and bottom
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", metrics: nil, views: dictionaryViews))

    }
    
    private func loadFromXib() -> UIView {
        
        // load the bundle where the xib belong
        
        let bundle = Bundle.main
//        let bundle = Bundle(for: type(of: self))
        
        // load the xib file
        
        let xib = UINib(nibName: "CustomView", bundle: bundle)
//        let xib  = UINib(nibName: String(describing: CustomView.self), bundle: bundle)
        
        // load the view and link with self
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
    
        return view
        
    }
}
