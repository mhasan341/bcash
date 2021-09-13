//
//  LoginViewController.swift
//  bCash
//
//  Created by Mahmud on 2021-09-13.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{

    // a carrat that dismisses the keyboard
    let backButton = UIButton()
    // a button that changes lang
    var langButton: BCButton!
    // there is an image on the left side
    var logoImageView: UIImageView!
    // a qr on the right side
    var qrImageView: UIImageView!
    // the page name
    var loginLabel: UILabel!
    // the instruction below, let's call it hint
    var loginHint: UILabel!
    
    // the account num
    var acNumberLabel: UILabel!
    // the label for showing ac number
    var acNumber: UILabel!
    // the pin label
    var pinLabel: UILabel!
    // the input
    var passwordTF: UITextField!
    // the forgot pin label
    var forgotLabel: UILabel!
    
    // the view and button for NEXT Button
    var nextView: UIView!
    var nextLabel: UILabel!
    var arrowRightImageView: UIImageView!
    
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    // for saving small values
    let ud = UserDefaults.standard
    
    // to save the nextView's height
    var nextViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // to comply with the system settings
        view.backgroundColor = .systemBackground
        // determine what lang to show
        configureLocale()
        // to hide keyboard on touch anywhere
        hideKeyboardOnOutsideTouch()
        
        
        
        // call the config functions
        // just for being quick, not adding comments here
        configureBackButton()
        configureLangButton()
        configureLogoImage()
        configureQRImage()
        configureLoginLabel()
        configureLoginHint()
        configureAC()
        configurePINInput()
        configureForgotPIN()
        configureNextButton()
        
        // set the texts as well
        refreshTexts()
        // so the nextView can popup
        configureKeyboard()
        

    }
    
    // we don't need any navbar here
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // before login, dismiss the keyboard
        if passwordTF.isFirstResponder{
            passwordTF.resignFirstResponder()
        }
        
    }
    
    // MARK:- DELEGATES

    // change the color of the nextView according to user input
    // also make it enable or not based on that
    func textFieldDidChangeSelection(_ textField: UITextField) {
       // optional wrapping
        if let userInput = textField.text?.count, userInput >= 4{
            nextView.backgroundColor = .systemBlue
            nextView.isUserInteractionEnabled = true
        }else{
            nextView.backgroundColor = .systemGray
            nextView.isUserInteractionEnabled = false
        }
    }

    
    
    
    
    // MARK:- Add the Back and LangChange
    func configureBackButton(){

        //add to the view
        view.addSubview(backButton)
        
        // DOC: A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
        backButton.translatesAutoresizingMaskIntoConstraints = false
        // set the image, the image is taken from SF symbol
        backButton.setImage(UIImage(systemName: "chevron.left",
                                withConfiguration: UIImage.SymbolConfiguration(weight:.regular))?
                                .withRenderingMode(.alwaysOriginal)
                                .withTintColor(.systemBlue), for: .normal)
        
        // set the constraints
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        
        ])
        
        // during initial setup, keyboard is hidden, hide the backbutton
        backButton.isHidden = true
    }
    
    func configureLangButton(){
        
        // init it first
        langButton = BCButton(title: "")
        
        //add to the view
        view.addSubview(langButton)
        
        // set the constraints
        NSLayoutConstraint.activate([
            langButton.widthAnchor.constraint(equalToConstant: 70),
            langButton.heightAnchor.constraint(equalToConstant: 40),
            langButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            langButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        // set the action of this button
        langButton.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
    }
    
    // method to respond for lang change button
    @objc func changeLanguage(){
        // check the locale then change
        checkAndSetLocale()
        // calling this method will update all text based views in app
        // need to find more efficient solution later
        refreshTexts()
        
    }
    
    // MARK:- THE LANGUAGE FUNCS
    
    // the button will show the opposite of what lang is showing
    // so we'll change the text value to the string files
    // so user knows which lang to switch
    // there should be a better way
    // but for this quick app a quick hack should be enough
    
    // return is app is showing english/ last used value
    func isShowingEnglish()->Bool{
        // by default show en
        return ud.bool(forKey: UD_DISPLAYED_EN_LANG)
    }
    
    // checks, sets and saves locale
    func checkAndSetLocale(){
        // change the lang and save to UserDefault
        if isShowingEnglish(){
            defaultLocalizer.setSelectedLanguage(lang: LANG_BN)
            // save to ud
            ud.setValue(false, forKey: UD_DISPLAYED_EN_LANG)
        }else{
            defaultLocalizer.setSelectedLanguage(lang: LANG_EN)
            // save to ud
            ud.setValue(true, forKey: UD_DISPLAYED_EN_LANG)
        }
    }
    
    
    // during view did load, only set the value
    func configureLocale(){
        // change the lang and save to UserDefault
        if isShowingEnglish(){
            defaultLocalizer.setSelectedLanguage(lang: LANG_EN)
        }else{
            defaultLocalizer.setSelectedLanguage(lang: LANG_BN)
        }
    }
    
    
    
    
    
    
    
    // MARK:- Add the logo and the qr
    
    // Usually I'd have create custom class for these
    // so I can reuse them later. But for the sake of simplicity
    // adding them directly
    
    func configureLogoImage(){
        
        // Usual comments
        // let's not repeat
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        // set the constraints
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 70),
            logoImageView.heightAnchor.constraint(equalToConstant: 70),
            logoImageView.topAnchor.constraint(equalTo: langButton.bottomAnchor, constant: 40),
            logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
    }
    
    func configureQRImage(){
        // Again, comments and lots of good stuff in production code
        qrImageView = UIImageView()
        // from good old friend, SFSymbols
        qrImageView.image = UIImage(systemName: "qrcode",
                                    withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?
                                    .withRenderingMode(.alwaysOriginal)
                                    .withTintColor(.systemBlue)
        
        view.addSubview(qrImageView)
        
        qrImageView.translatesAutoresizingMaskIntoConstraints = false
        // set the constraints
        NSLayoutConstraint.activate([
            qrImageView.widthAnchor.constraint(equalToConstant: 60),
            qrImageView.heightAnchor.constraint(equalToConstant: 60),
            qrImageView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            qrImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        // add a tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(qrImageTapped))
        // without it we won't be able to get the events
        qrImageView.isUserInteractionEnabled = true
        qrImageView.addGestureRecognizer(tap)
        
        
    }
    
    @objc func qrImageTapped(){
        showErrorBanner(withMessage: NO_QR.localized())
    }
    // MARK:- ADD THE LOGIN TEXTS
    
    func configureLoginLabel(){
        loginLabel = UILabel()
        loginLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        view.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // set the constraints
        NSLayoutConstraint.activate([
            loginLabel.heightAnchor.constraint(equalToConstant: 30),
            loginLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20)
        ])
    }
    
    
    func configureLoginHint(){
        loginHint = UILabel()
        
        loginHint.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.addSubview(loginHint)
        loginHint.translatesAutoresizingMaskIntoConstraints = false
        
        // set the constraints
        NSLayoutConstraint.activate([
            loginHint.heightAnchor.constraint(equalToConstant: 30),
            loginHint.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginHint.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK:- ADD THE INPUTS (FAKE OBVIOUSLY)
    
    func configureAC(){
        acNumberLabel = UILabel()
        
        acNumberLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        acNumberLabel.textColor = .systemGray
        
        view.addSubview(acNumberLabel)
        acNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // set the constraints
        NSLayoutConstraint.activate([
            acNumberLabel.heightAnchor.constraint(equalToConstant: 30),
            acNumberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            acNumberLabel.topAnchor.constraint(equalTo: loginHint.bottomAnchor, constant: 10)
        ])
        
        
        // In real life it would be a TF with value from some DB usually from keychain
        // The phone number is a personal info, so won't be wise to save to UD
        // but for this demo, just adding a label
        
        acNumber = UILabel()
        
        acNumber.text = "+88 01700123456"
        acNumber.font = UIFont.preferredFont(forTextStyle: .headline)
        acNumber.textColor = .label
        
        view.addSubview(acNumber)
        acNumber.translatesAutoresizingMaskIntoConstraints = false
        
        // set the constraints
        NSLayoutConstraint.activate([
            acNumber.heightAnchor.constraint(equalToConstant: 30),
            acNumber.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            acNumber.topAnchor.constraint(equalTo: acNumberLabel.bottomAnchor, constant: 0)
        ])
    }
    
    
    func configurePINInput(){
        
        pinLabel = UILabel()
        
        pinLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        pinLabel.textColor = .systemGray
        
        view.addSubview(pinLabel)
        pinLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // set the constraints
        NSLayoutConstraint.activate([
            pinLabel.heightAnchor.constraint(equalToConstant: 30),
            pinLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pinLabel.topAnchor.constraint(equalTo: acNumber.bottomAnchor, constant: 5)
        ])
        
        // The password field, our only active input here
        
        passwordTF = UITextField()
        passwordTF.placeholder = "Enter PIN here"
        
        passwordTF.font = UIFont.preferredFont(forTextStyle: .subheadline)
        passwordTF.textColor = .label
        
        // as this is a password/pin input, we need to hide it
        // we could add hide/show icon as well
        passwordTF.isSecureTextEntry = true
        passwordTF.tintColor = .systemBlue
        passwordTF.keyboardType = .numberPad
        passwordTF.autocorrectionType = .no
    

        
        
        view.addSubview(passwordTF)
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        
        // set the constraints
        NSLayoutConstraint.activate([
            passwordTF.heightAnchor.constraint(equalToConstant: 30),
            passwordTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTF.topAnchor.constraint(equalTo: pinLabel.bottomAnchor, constant: 0)
        ])
        
        
        // set the delegate of passfield
        passwordTF.delegate = self
        
        
    }
    
    // MARK:- THE FORGOT PIN LABEL
    
    func configureForgotPIN(){
        forgotLabel = UILabel()
        
        forgotLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        forgotLabel.textColor = .systemBlue
        
        view.addSubview(forgotLabel)
        forgotLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // set the constraints
        NSLayoutConstraint.activate([
            forgotLabel.heightAnchor.constraint(equalToConstant: 30),
            forgotLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            forgotLabel.centerYAnchor.constraint(equalTo: pinLabel.centerYAnchor)
        ])
        
        // enable the interaction and add the gesture
        forgotLabel.isUserInteractionEnabled = true
        forgotLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgotPinTapped)))
    }
    
    @objc func forgotPinTapped(){
        showErrorBanner(withMessage: FORGOT_PIN_ERROR.localized())
    }
    
    // MARK:- ADD THE NEXT BUTTON
    
    func configureNextButton(){
        
        
        nextView = UIView()
        nextView.translatesAutoresizingMaskIntoConstraints = false
        nextView.backgroundColor = UIColor.systemGray
        view.addSubview(nextView)
        
        nextViewBottomConstraint = nextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        
        // set the constraints
        
        NSLayoutConstraint.activate([
            nextView.heightAnchor.constraint(equalToConstant: 50),
            nextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            nextViewBottomConstraint
        ])
        
        
        // NOW ADD THE NEXT BUTTONS
        nextLabel = UILabel()
        arrowRightImageView = UIImageView()
        
        nextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        arrowRightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nextLabel.textColor = .white
        
        arrowRightImageView.image = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        
        
        nextView.addSubview(nextLabel)
        nextView.addSubview(arrowRightImageView)
        
        
        // set the constraints
        NSLayoutConstraint.activate([
            nextLabel.heightAnchor.constraint(equalToConstant: 30),
            nextLabel.leadingAnchor.constraint(equalTo: nextView.leadingAnchor, constant: 20),
            nextLabel.centerYAnchor.constraint(equalTo: nextView.centerYAnchor),
            
            arrowRightImageView.heightAnchor.constraint(equalToConstant: 30),
            arrowRightImageView.widthAnchor.constraint(equalToConstant: 30),
            arrowRightImageView.trailingAnchor.constraint(equalTo: nextView.trailingAnchor, constant: -20),
            arrowRightImageView.centerYAnchor.constraint(equalTo: nextView.centerYAnchor),
            
        ])
        
        // add the action
        addTapToNext()
        // we don't want to enable it right on the start
        nextView.isUserInteractionEnabled = false
    }
    
    // also add a tap gesture on next button
    
    func addTapToNext(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(doLogin))
        nextView.addGestureRecognizer(tap)
    }
    
    @objc func doLogin(){
        
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        guard let navController = navigationController else {
            print("Nav is nil")
            return
        }
        navController.pushViewController(mainVC, animated: true)
       // self.present(mainVC, animated: true, completion: nil)
    }
    
    
    // MARK:- REFRESH THE LANG DEPENDENT VIEWS
    
    // this method is called whenever we change the language
    // not adding comment to save time
    
    func refreshTexts(){
        
        langButton.setTitle(LANG_BUTTON_TITLE.localized(), for: .normal)
        loginLabel.text = LOGIN_LABEL_TITLE.localized()
        loginHint.text = LOGIN_LABEL_HINT.localized()
        acNumberLabel.text = ACCOUNT_NUMBER_LABEL.localized()
        pinLabel.text = BCASH_PIN_LABEL.localized()
        forgotLabel.text = FORGOT_PIN_LABEL.localized()
        nextLabel.text = NEXT_LABEL.localized()
    }
    
    
    // MARK:- TO LIFT UP THE NEXT BUTTON WITH KEYBOARD
    
    // The two method were from my old TrapSpy project
    // slighly changed
    // taken from stackoverflow at that time
    // there should be better implementation, but this one is good enough for this example
    
    func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        // when keyboard is showing, show the back
        // bKash design
        backButton.isHidden = false
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("KEYBOARD HEIGHT: \(keyboardSize.height)")
            
            self.nextViewBottomConstraint.constant -= keyboardSize.height
            UIView.animate(withDuration: 0.5){
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
            
            
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        // when keyboard is hiding, hide the backbutton
        backButton.isHidden = true
        
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.nextViewBottomConstraint.constant =  0

            UIView.animate(withDuration: 0.5){
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
    
        }
        
    }

}
