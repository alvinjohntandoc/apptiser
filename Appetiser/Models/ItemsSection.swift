//
//  ItemsSection.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 17/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionOfMovies {
    var header: String
    var items: [Item]
}

extension SectionOfMovies: SectionModelType {
    typealias Item = Movie
    
    init(original: SectionOfMovies, items: [Item]) {
        self = original
        self.items = items
    }
}
