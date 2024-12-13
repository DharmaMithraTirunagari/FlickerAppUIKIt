//
//  DetailViewController.swift
//  FlickerAppUIKIt
//
//  Created by Srikanth Kyatham on 12/12/24.
//

import UIKit

class DetailViewController: UIViewController {
    var photo: FlickrPhoto?
    var photoImage: UIImage?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureView()
        view.backgroundColor = UIColor.systemGroupedBackground
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            infoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureView() {
        guard let photo = photo else { return }
        
        imageView.image = photoImage
        infoLabel.text = """
        Title: \(photo.title.isEmpty ? "N/A" : photo.title)
        Author: \(photo.author)
        Published: \(photo.published)
        """
    }
}
