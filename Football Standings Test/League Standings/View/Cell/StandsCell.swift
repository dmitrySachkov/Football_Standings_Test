//
//  StandsCell.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 09.04.2022.
//

import UIKit

class StandsCell: UITableViewCell {
    

    private var factory = NetworkService()
    
    private var backgroundImageView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.9)
        return view
    }()
    
    private var imageLabel: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var winsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var lossesLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var tiesLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var pointsLabel: UILabel = {
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
        backgroundImageView.layer.cornerRadius = backgroundImageView.frame.size.width / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: Setup UI
    private func setupUI() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(imageLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(winsLabel)
        contentView.addSubview(lossesLabel)
        contentView.addSubview(tiesLabel)
        contentView.addSubview(pointsLabel)
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 75),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 75),
            
            imageLabel.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            imageLabel.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            imageLabel.widthAnchor.constraint(equalToConstant: 50),
            imageLabel.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            winsLabel.leadingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: 15),
            winsLabel.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width - 101) / 3),
            winsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5),
            winsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            lossesLabel.leadingAnchor.constraint(equalTo: winsLabel.trailingAnchor),
            lossesLabel.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width - 101) / 3),
            lossesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5),
            lossesLabel.heightAnchor.constraint(equalToConstant: 20),
            
            tiesLabel.leadingAnchor.constraint(equalTo: lossesLabel.trailingAnchor),
            tiesLabel.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width - 117) / 3),
            tiesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5),
            tiesLabel.heightAnchor.constraint(equalToConstant: 20),
            
            pointsLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10),
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pointsLabel.topAnchor.constraint(equalTo: winsLabel.bottomAnchor, constant: 15),
            pointsLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
   
    //MARK: Configure Cell
    func configureCell(teamName: String, wins: String, loss: String, ties: String, points: String, image: String) {
        titleLabel.text = teamName
        winsLabel.text = "Wins: \(wins)"
        lossesLabel.text = "Loss: \(loss)"
        tiesLabel.text = "Draw: \(ties)"
        pointsLabel.text = "Points: \(points)"
        factory.fetchImage(urlStr: image, completion: { result in
            self.imageLabel.image = result
        })
    }
}
