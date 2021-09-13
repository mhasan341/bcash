//
//  String+Ext.swift
//  bCash
//
//  Created by Mahmud on 2021-09-13.
//

import UIKit

// this extension will handle the localization for us
extension String {
    func localized()-> String{
        // DOC:- Returns a localized string, using the main bundle if one is not specified.
        // Added the bundle that we got from AMPLocalizeUtils class
        return NSLocalizedString(self, tableName: "Localize", bundle: AMPLocalizeUtils.defaultLocalizer.appbundle, value: self, comment: self)
    }
}
