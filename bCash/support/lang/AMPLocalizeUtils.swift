//
//  AMPLocalizeUtils.swift
//  MyCatalogue
//
//  Created by anoopm on 09/02/17.
//  Copyright © 2017 anoopm. All rights reserved.
//

// from: https://github.com/anoop4real/LanguageSettings/blob/master/LanguageSettings/AMPLocalizeUtils.swift

import UIKit

class AMPLocalizeUtils: NSObject {
    
    static let defaultLocalizer = AMPLocalizeUtils()
    var appbundle = Bundle.main
    
    func setSelectedLanguage(lang: String) {
        guard let langPath = Bundle.main.path(forResource: lang, ofType: "lproj") else {
            print("Using default")
            appbundle = Bundle.main
            return
        }
        
        appbundle = Bundle(path: langPath)!
    }
    
}
