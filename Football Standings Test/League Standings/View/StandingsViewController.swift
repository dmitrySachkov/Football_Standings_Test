//
//  StandingsViewController.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 09.04.2022.
//

import UIKit
import Combine

class StandingsViewController: UIViewController {
   
    var id = ""
    var season = 0
    private let tableView = UITableView()
    private var viewModel: LeagueStandingViewModel?
    private var canseleble = Set<AnyCancellable>()
    private let spinner : UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView(style: .medium)
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        loginSpinner.hidesWhenStopped = true
        return loginSpinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LeagueStandingViewModel(urlString: baseURL + "/\(id)/standings?season=\(season)")
        setupUI()
        binding()
    }
    
    //MARK: Setup UI
    private func setupUI() {
        navigationItem.title = "STANDINGS"
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white]
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StandsCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = .white
    }
    
    //MARK: Binding
    private func binding() {
        viewModel?.$model
            .sink { _ in } receiveValue: { [weak self] model in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if model != nil {
                        self.spinner.stopAnimating()
                        self.tableView.reloadData()
                    } else {
                        self.spinner.startAnimating()
                    }
                }
            }
            .store(in: &canseleble)
    }
}

//MARK: Table View Data Sourse and Delegate
extension StandingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.model?.data.standings.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? StandsCell else { return UITableViewCell() }
        let model = viewModel?.model?.data.standings[indexPath.row]
        cell.configureCell(teamName: model?.team.displayName ?? "",
                           wins: model?.stats[0].displayValue ?? "",
                           loss: model?.stats[1].displayValue ?? "",
                           ties: model?.stats[2].displayValue ?? "",
                           points: model?.stats[6].displayValue ?? "",
                           image: model?.team.logos[0].href ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
