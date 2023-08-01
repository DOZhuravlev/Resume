//
//  CustomFonts.swift
//  Resume
//
//  Created by Zhuravlev Dmitry on 01.08.2023.
//

import UIKit

enum CustomFonts: String {
    case sfProDisplayBold = "SFProDisplay-Bold"
    case sfProDisplayMedium = "SFProDisplay-Medium"
    case sfProDisplayRegular = "SFProDisplay-Regular"


    func font(size: CGFloat) -> UIFont? {
        return UIFont(name: self.rawValue, size: size)
    }
}
