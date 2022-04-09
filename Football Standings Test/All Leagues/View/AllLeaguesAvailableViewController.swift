//
//  ViewController.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 08.04.2022.
//

import UIKit
import Combine

class AllLeaguesAvailableViewController: UIViewController {
    
    private let tableView = UITableView()
    private var viewModel = AllLeaguesViewModel()
    private var canseleble = Set<AnyCancellable>()
    private let spinner : UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView(style: .medium)
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        loginSpinner.hidesWhenStopped = true
        return loginSpinner
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        binding()
    }
    
    //MARK: Setup UI
    private func setupUI() {
        navigationItem.title = "ALL LEAGUES"
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white]
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AllLeagesCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = .white
    }
    
    //MARK: Binding
    private func binding() {
        viewModel.$model
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
extension AllLeaguesAvailableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AllLeagesCell else { return UITableViewCell() }
        if let model = viewModel.model?.data[indexPath.row] {
            cell.configureCell(image: model.logos.light, name: model.name, abbr: model.abbr)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = AllSeasonController()
        vc.id = viewModel.model?.data[indexPath.row].id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}
