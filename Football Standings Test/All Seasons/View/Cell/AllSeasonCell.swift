//
//  TableViewCell.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 09.04.2022.
//

import UIKit

class AllSeasonCell: UITableViewCell {
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var startLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var endLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var statusLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black.withAlphaComponent(0.8)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: Setup UI
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(startLabel)
        contentView.addSubview(endLabel)
        contentView.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
        
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            startLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            startLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            startLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            startLabel.heightAnchor.constraint(equalToConstant: 20),

            endLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            endLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            endLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 5),
            endLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    //MARK: Configure Cell
    func configureCell(title: String, start: String, end: String) {
        let startDate = dateFormate(start)
        let endDate = dateFormate(end)
        titleLabel.text = title
        startLabel.text = "Start date: \(startDate)"
        endLabel.text = "End date: \(endDate)"
    }
    
    //MARK: Date Formatter
    private func dateFormate(_ string: String) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        guard let stDate = df.date(from: string) else { return "" }
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: stDate)
        return date
    }
}
