//
//  ATMovieListViewModel.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 17/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol MovieListViewModel {
    
    /// Fetch movie list from itunes api, completable will emit if the request is successful
    /// After parsing the api response using codable, this func has a side effect of saving the objects to realm
    func fetchMovieList() -> Completable
    
    /// Will emit everytime movies object from realm was updated
    var movies: Observable<[SectionOfMovies]> { get }
    
    /// Will emit last date
}

class ATMovieListViewModel: MovieListViewModel, ItunesProvider {
    
    private enum Constants {
        static let keyword: String = "star"
        static let country: String = "au"
        static let media: MediaType = .movie
    }
    
    var disposeBag = DisposeBag()
    
    var itunesAPIProvider: MoyaProvider<ItunesAPI> = MoyaProvider<ItunesAPI>()
    
    lazy var movies: Observable<[SectionOfMovies]> = {
        return self.moviesFromRealm()
            .map { [SectionOfMovies(header: "", items: $0)] }
    }()
    .share(replay: 1, scope: .whileConnected)
    
    init() {
        self.fetchMovieList()
        .subscribe()
        .disposed(by: disposeBag)
    }
    
    //MARK: - Fetch Movie List
    func fetchMovieList() -> Completable {
        return itunesAPIRequest(keyword: Constants.keyword,
            country: Constants.country,
            mediaType: Constants.media)
            .do(onSuccess: { [weak self] (response) in
                guard let self = self else { return }
                self.saveMovies(movies: response.movies)
            })
            .asCompletable()
    }
    
    //MARK: - Save Movies
    /// Save movies to realm
    func saveMovies(movies: [Movie]) {
        self.saveMoviesToRealm(movies: movies)
        .disposed(by: disposeBag)
    }
    
}
