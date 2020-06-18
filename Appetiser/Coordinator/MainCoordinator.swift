//
//  MainCoordinator.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 17/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//


import Foundation
import UIKit
import RxSwift

protocol MainCoordinator {
	/// Root View Controller
	var navigationController: UINavigationController { get }
	
	/// Will show movie list screen
	func start()
	
	/// Will transfer to movie details
    ///
    /// - Parameters:
    ///     - movie: Selected movie the will be displayed in the next screen
    ///     - backgroundColor: Background color of the next screen
    func transferToMovieDetailsView(movie: Movie, backgroundColor: UIColor)
}

class ATMainCoordinator: Coordinator, MainCoordinator {
	
	var wantsToDismiss: Observable<Void> {
		return Observable.empty()
	}
	
	var navigationController: UINavigationController
	
	var childCoordinators: [Coordinator] = [Coordinator]()
	
	private var disposeBag: DisposeBag = DisposeBag()
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
    // MARK: - Start
	func start() {
        let viewModel = ATMovieListViewModel()
        let movieListViewControler: ATMovieListViewController = ATMovieListViewController(coordinator: self, viewModel: viewModel)
        self.navigationController.pushViewController(movieListViewControler, animated: true)
	}
	
    // MARK: - Transfer To Movie Details
	func transferToMovieDetailsView(movie: Movie, backgroundColor: UIColor) {
        let viewModel = ATMovieDetailsViewModel(movie: movie)
		
        let movieDetailsView = ATMovieDetailsViewController(coordinator: self, viewModel: viewModel, gradientColor: backgroundColor)
        
        self.navigationController.pushViewController(movieDetailsView, animated: true)
	}
}
