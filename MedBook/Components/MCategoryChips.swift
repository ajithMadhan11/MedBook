//
//  MCategoryChips.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI

struct MCategoryChips: View {
    
    private var categoryList: [String] = ["All Books", "Journal", "Novel", "Science", "Programming", "Technology"]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(categoryList, id: \.self) { category in
                    categoryChip(title: category, isSelected: category == "All Books")
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func categoryChip(title: String, isSelected: Bool = false) -> some View {
        Text(title)
            .font(MFont.MBold(14))
            .frame(height: 40)
            .padding(.horizontal)
            .background(isSelected ? MColor.primaryGreen : Color(UIColor.systemGray5))
            .foregroundStyle(isSelected ? Color.white : Color.gray)
            .cornerRadius(20)
        
    }
}

#Preview {
    MCategoryChips()
}
