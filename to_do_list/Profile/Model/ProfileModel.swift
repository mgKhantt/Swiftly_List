//
//  ProfileModel.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 15/07/2025.
//

import Foundation
import UIKit

struct ProfileModel: Codable {
    var name: String
    var email: String
    var phone_number: String
    
    init(name: String, email: String, phone_number: String) {
        self.name = name
        self.email = email
        self.phone_number = phone_number
    }
}
