//
//  Extensions.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 18/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /// Convert string to url
    var toUrl: URL? {
        return URL(string: self)
    }
}


extension UIViewController {
    /// Setup Large title and change background color of the navigation bar
    ///
    /// - Parameters:
    ///     - color: Background color of the navigation bar
    func setupLargeTitleBackgroundColor(color: UIColor) {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithDefaultBackground()
        
        navBarAppearance.backgroundColor = color
        
        let buttonAppearance = UIBarButtonItemAppearance()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        buttonAppearance.normal.titleTextAttributes = titleTextAttributes
        
        navBarAppearance.titleTextAttributes = [
            .foregroundColor : UIColor.black,
        ]
        
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor : UIColor.black,
        ]
        
        let transNavBarAppearance = navBarAppearance.copy()
        transNavBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = transNavBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension Double {
    /// Convert AU currency
    var toCurrency: String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_AU")
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self))
    }
    
}

