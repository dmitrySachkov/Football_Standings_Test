//
//  AllSeasonController.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 09.04.2022.
//

import UIKit
import Combine

class AllSeasonController: UIViewController {
    
    var id = ""
    private let tableView = UITableView()
    private var viewModel: AllSeasonsViewModel?
    private var canseleble = Set<AnyCancellable>()
    private let spinner : UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView(style: .medium)
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        loginSpinner.hidesWhenStopped = true
        return loginSpinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AllSeasonsViewModel(urlString: baseURL + "/\(id)/seasons")
        setupUI()
        binding()
    }
    
    //MARK: Setup UI
    private func setupUI() {
        navigationItem.title = "ALL SEASONS"
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white]
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AllSeasonCell.self, forCellReuseIdentifier: "cell")
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
extension AllSeasonController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.model?.data.seasons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AllSeasonCell else { return UITableViewCell() }
        let model = viewModel?.model?.data.seasons[indexPath.row]
        cell.configureCell(title: model?.displayName ?? "", start: model?.startDate ?? "", end: model?.endDate ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = StandingsViewController()
        vc.id = id
        vc.season = viewModel?.model?.data.seasons[indexPath.row].year ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }
}
