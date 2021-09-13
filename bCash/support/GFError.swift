//
//  GFError.swift
//  GHFollowers
//
//  Created by Sean Allen on 1/11/20.
//  Copyright © 2020 Sean Allen. All rights reserved.
//

// Taken from this course: https://seanallen.teachable.com/courses/681906
// Slighly modified for this project
// I've done that course

import Foundation

enum GFError: String, Error {
    
    case invalidUrl    = "The format of this url is incorrect"
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}
