//
//  UIViewController+Ext.swift
//  bCash
//
//  Created by Mahmud on 2021-09-13.
//

import UIKit

// copied from one of my recent project
extension UIViewController{
    // to dismiss the keyboard
    func hideKeyboardOnOutsideTouch() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // this function shows a error banner with the message provided
    func showErrorBanner(withMessage text: String){
        // the actual banner
        let bannerView = UIView()
        // add it to the view
        view.addSubview(bannerView)
        // the good old stuff
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        // error banner, red makes sense
        bannerView.backgroundColor = .systemRed
        
        // the label inside the banner
        let errorLabel = UILabel()
        errorLabel.text = text
        
        errorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        errorLabel.textColor = .white
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
 
        
        // add the label to display
        bannerView.addSubview(errorLabel)
        
        
        // make a cross button
        let crossButton = UIButton()
        bannerView.addSubview(crossButton)
        crossButton.translatesAutoresizingMaskIntoConstraints = false
        
        crossButton.setImage( UIImage(systemName: "multiply",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?
                                .withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        
        
        
        // set the constraints
        NSLayoutConstraint.activate([
            bannerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            bannerView.heightAnchor.constraint(equalToConstant: 50),
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            
            // now the label
            errorLabel.heightAnchor.constraint(equalToConstant: 30),
            errorLabel.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor, constant: 0),
            errorLabel.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 20),
            
            // the button
            crossButton.heightAnchor.constraint(equalToConstant: 30),
            crossButton.widthAnchor.constraint(equalToConstant: 30),
            crossButton.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor, constant: 0),
            crossButton.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: -20),
            
        ])
        
        
        // adding an action to dismiss the banner view with a simple animation
        crossButton.addAction(UIAction{(action: UIAction) in
            
            UIView.animate(withDuration: 1) {
                bannerView.alpha = 0
            } completion: { animationCompleted in
                bannerView.removeFromSuperview()
            }

            
        }, for: .touchUpInside)
        

    } // end of error banner
    
}
