//
//  BCButton.swift
//  bCash
//
//  Created by Mahmud on 2021-09-13.
//

import UIKit

// Like this button, any UIView can be designed using programaticUI
// Only used this button once, so it wasn't required to do separately
// But for the sake of showing demo, here we go

class BCButton: UIButton {

    // default init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // it is a must when subclassing UIKit widget/component
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String){
        // we'll set the frame using auto layout
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        
        configure()
    }
    
    
    // we'll customize our button here
    // do our magic
    // and make the button
    private func configure(){
        // configuring the custom button
        // the code can speak for itself
        layer.backgroundColor = UIColor.systemBackground.cgColor
        self.setTitleColor(.systemBlue, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        layer.cornerRadius = 20
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1
        
        
        // we are doing it programatically and will be using auto layout
        // so we need this to set false
        // FROM DOC: A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
