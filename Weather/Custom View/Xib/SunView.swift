//
//  SunView.swift
//  Weather
//
//  Created by Константин Киски on 29.04.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation
import UIKit

class SunView: UIView {
    
    // MARK: - UI Elements
    
    @IBOutlet private weak var imageSun: UIImageView!
    @IBOutlet private weak var timeSun: UILabel!
    
    var view: UIView!

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
     
    func setSun(date: Date, image: UIImage) {
        imageSun.image = image
        timeSun.text = returnDateString(date: date)
    }

    // MARK: - Helper func
     
    private func returnDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = .current
        return "\(dateFormatter.string(from: date))"
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
        let nib = UINib(nibName: "SunView", bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
     
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        view?.prepareForInterfaceBuilder()
    }
}
