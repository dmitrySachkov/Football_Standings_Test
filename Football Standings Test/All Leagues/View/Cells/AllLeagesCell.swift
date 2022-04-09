//
//  AllLeagesCell.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 08.04.2022.
//

import UIKit

class AllLeagesCell: UITableViewCell {
    
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
    
    private var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var abbrLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(abbrLabel)
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 95),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 95),
            
            imageLabel.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            imageLabel.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            imageLabel.widthAnchor.constraint(equalToConstant: 70),
            imageLabel.heightAnchor.constraint(equalToConstant: 70),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageLabel.trailingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            abbrLabel.leadingAnchor.constraint(equalTo: imageLabel.trailingAnchor, constant: 25),
            abbrLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            abbrLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
        ])
    }
   
    //MARK: Configure Cell
    func configureCell(image: String, name: String, abbr: String) {
        nameLabel.text = name
        abbrLabel.text = abbr
        factory.fetchImage(urlStr: image, completion: { result in
            self.imageLabel.image = result
        })
    }
}
