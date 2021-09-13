//
//  GitUsers.swift
//  bCash
//
//  Created by Mahmud on 2021-09-13.
//

import Foundation

struct GitUsers: Codable {
    // the username
    let login: String
    // the profile pic of that user
    let avatarUrl: String
    // url to the profile of this user
    let url: String
}
