//
//  ViewExt.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 11/07/2025.
//

import Foundation
import SwiftUICore
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder().resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


