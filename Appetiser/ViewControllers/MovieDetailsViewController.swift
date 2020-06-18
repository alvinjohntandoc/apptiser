//
//  MovieDetailsViewController.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 18/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class ATMovieDetailsViewController : UIViewController {
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    private var coordinator: MainCoordinator
    
    private var viewModel: MovieDetailsViewModel
    
    private var backgroundColor: UIColor
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    deinit {
        print("🐼🐼🐼 ATMovieDetailsViewController deinit")
    }
    
    init(coordinator: MainCoordinator, viewModel: MovieDetailsViewModel, gradientColor: UIColor) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.backgroundColor = gradientColor
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.coordinator = ATMainCoordinator(navigationController: UINavigationController())
        self.viewModel = ATMovieDetailsViewModel(movie: Movie())
        self.backgroundColor = UIColor.white
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLargeTitleBackgroundColor(color: backgroundColor)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = backgroundColor
        view.layoutIfNeeded()
        
        title = viewModel.movie.trackPrice.toCurrency
        
        tableView.register(MovieDetailsTableViewCell.self, forCellReuseIdentifier: MovieDetailsTableViewCell.Constants.reuseIdentifier)
        
        tableView.dataSource = self
        tableView.reloadData()
        
        view.addSubview(tableView)
        
        setupHeaderView()
    }
    
    // MARK: - Setup Header View
    private func setupHeaderView() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let headerView = MovieHeaderView(movie: viewModel.movie)
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        
        tableView.tableHeaderView = headerView
        headerView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}

//MARK: - Table View Data Source
extension ATMovieDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.Constants.reuseIdentifier) as! MovieDetailsTableViewCell
        cell.bind(viewModel.movie)
        return cell
    }
    
}

