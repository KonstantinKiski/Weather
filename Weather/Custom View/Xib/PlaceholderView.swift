//
//  PlaceholderView.swift
//  Weather
//
//  Created by Константин Киски on 29.04.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class PlaceholderView: UIView {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet private weak var loaderView: SpinnerView!
    
    var view: UIView!

    // MARK: - Closure
    
    private var retryLoadData: () -> () = { }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    // MARK: - Set data
    
    func setLoad() {
        loaderView.isHidden = false
        errorView.isHidden = true
    }
    
    func setError(buttonAction: @escaping () -> ()) {
        loaderView.isHidden = true
        errorView.isHidden = false
        self.retryLoadData = buttonAction
    }
    
    // MARK: - UI Actions
    
    @IBAction func retryButton(_ sender: Any) {
        retryLoadData()
    }
    
    // MARK: - Set view

    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PlaceholderView", bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        view?.prepareForInterfaceBuilder()
    }
}
