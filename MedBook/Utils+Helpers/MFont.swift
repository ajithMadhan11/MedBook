//
//  MFont.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 08/08/24.
//

import SwiftUI

struct MFont {
    
    static func MBold(_ size: CGFloat) -> Font {
        Font.custom("Poppins-Bold", size: size)
    }
    
    static func MRegular(_ size: CGFloat) -> Font {
        Font.custom("Poppins-Regular", size: size)
    }
}
