//
//  AddView.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 09/07/2025.
//

import SwiftUI

struct AddView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    
    
    var body: some View {
        
            
        
        
        
        
    }
}

#Preview {
    NavigationView {
        AddView()
    }
}

//            Button(action: {
//                if textFieldText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//                    showEmptyTextAlert = true
//                    return
//                }
//                listViewModel.addItem(title: textFieldText)
//                textFieldText = ""
//                hideKeyboard()
//            }) {
//                Text("Save")
//                    .bold()
//                    .padding(.horizontal, 16)
//            }
//            .buttonStyle(.borderedProminent)
