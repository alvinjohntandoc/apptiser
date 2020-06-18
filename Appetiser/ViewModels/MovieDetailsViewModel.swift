//
//  MovieDetailsViewModel.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 18/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModel {
    var movie: Movie { get }
}

class ATMovieDetailsViewModel: MovieDetailsViewModel {
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
}

