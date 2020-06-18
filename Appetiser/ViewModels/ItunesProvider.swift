//
//  ItunesProvider.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 17/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxRealm
import RealmSwift

protocol ItunesProvider: class {
    var itunesAPIProvider: MoyaProvider<ItunesAPI> { get }
    
    func itunesAPIRequest(keyword: String, country: String, mediaType: MediaType) -> Single<ItunesResponse>
    
    func moviesFromRealm() -> Observable<[Movie]> 
}

extension ItunesProvider {
    
    func itunesAPIRequest(keyword: String, country: String, mediaType: MediaType) -> Single<ItunesResponse> {
        
        return itunesAPIProvider
            .rx.request(.search(keyword: keyword, country: country, media: mediaType))
            .map(ItunesResponse.self)
    }
    
    func saveMoviesToRealm(movies: [Movie]) -> Disposable  {
        
        return Observable.from(optional: movies)
        .subscribe(Realm.rx.add())
    }
    
    func moviesFromRealm() -> Observable<[Movie]> {
        let realm = try! Realm()
        let movies = realm.objects(Movie.self)

        return Observable.collection(from: movies)
            .map { $0.toArray() }
    }
    
}

