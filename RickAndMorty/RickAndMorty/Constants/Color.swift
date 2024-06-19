//
//  Color.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 16.06.2024.
//

import Foundation
import UIKit.UIColor

enum Color {
    static let backgroundView: UIColor = .systemBackground
    static let mainTitleNavBar = UIColor(named: "textColor") ?? UIColor.label
    static let secondaryText: UIColor = .gray
    
    static let aliveStatus = UIColor(red: 92/255, green: 173/255, blue: 74/255, alpha: 1.0) 
    static let deadStatus = UIColor(red: 161/255, green: 20/255, blue: 10/255, alpha: 1.0)
    static let unknownStatus = UIColor(red: 237/255, green: 207/255, blue: 107/255, alpha: 1.0)
}
