//
//  AddView.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 09/07/2025.
//

import SwiftUI

struct AddView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var textFieldText: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
            TextField("Enter the task", text: $textFieldText)
                .padding()
                .background(Color.secondary.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 10)
            Button {
                if textFieldText == "" {
                    showAlert = true
                    return
                }
                listViewModel.addItem(title: textFieldText)
                textFieldText = ""
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
            }
            .alert("Please fill the text field", isPresented: $showAlert){
                Button(role: .cancel) {
                    
                } label: {
                    Text("OK")
                }
            }
            .padding(.horizontal, 10)
            .buttonStyle(.borderedProminent)
        
    }
}

#Preview {
    NavigationView {
        AddView()
    }
}
