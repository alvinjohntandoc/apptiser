//
//  ATMovieListViewController.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 17/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class ATMovieListViewController: UIViewController {
    
    private enum Constants {
        static let title = "Movie List"
    }
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    private var coordinator: MainCoordinator
    
    private var viewModel: MovieListViewModel
    
    init(coordinator: MainCoordinator, viewModel: MovieListViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.coordinator = ATMainCoordinator(navigationController: UINavigationController())
        self.viewModel = ATMovieListViewModel()
        
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("🐼🐼🐼 ATMovieListViewController deinit")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.clipsToBounds = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRxDataSources()
        setupCellSelection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLargeTitleBackgroundColor(color: UIColor.white)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupTableView()
        setupView()
        setupCell()
    }
    
    //MARK: Register Cell
    private func setupCell() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.Constants.reuseIdentifier)
    }
    
    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = UIColor.white
        title = Constants.title
    }
    
    // MARK: - Setup Table View
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Setup RX Data Sources
    private func setupRxDataSources() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfMovies>(
            configureCell: { dataSource, tableView, indexPath, item in
                
                let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.Constants.reuseIdentifier, for: indexPath) as! MovieTableViewCell
                
                cell.bind(item)
                
                return cell
        })
        
        viewModel.movies
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
            .asDriver()
            .drive(onNext: { (cell, indexPath) in
                if let cell = cell as? MovieTableViewCell {
                    cell.contentView.setNeedsLayout()
                    cell.contentView.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupCellSelection() {
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Movie.self))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (indexPath, movie) in
                guard let self = self else { return }
                if let cell = self.tableView.cellForRow(at: indexPath) as? MovieTableViewCell {
                    self.coordinator.transferToMovieDetailsView(movie: movie, backgroundColor: cell.color)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
