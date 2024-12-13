//
//  PhotoCell.swift
//  FlickerAppUIKIt
//
//  Created by Srikanth Kyatham on 12/12/24.
//


import UIKit

class PhotoCell: UICollectionViewCell {
    static let identifier = "PhotoCell"
    
        let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with imageUrl: String) {
        Task {
            if let image = await ImageCache.shared.loadImage(from: imageUrl) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "placeholder")
                }
            }
        }
    }

}

