//
//  ViewController.swift
//  FlickerAppUIKIt
//
//  Created by Srikanth Kyatham on 12/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - properties
    private let viewModel = PhotoViewModel()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Flickr Search"
        label.font = UIFont(name: "AvenirNext-Bold", size: 24)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search images..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    //MARK: - view controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        bindViewModel()
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        viewModel.fetchPhotos()
        setupCollectionViewLayout()
    }
    
    //MARK: - helpers
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.systemGroupedBackground
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let itemsPerRow: CGFloat = 3
        let totalSpacing = (itemsPerRow - 1) * spacing + 16
        let itemWidth = (view.frame.width - totalSpacing) / itemsPerRow

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 8, bottom: spacing, right: 8)
        
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .always
    }
    
    private func bindViewModel() {
        viewModel.onPhotosUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - CollectionView Data source methods

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        let photo = viewModel.photo(at: indexPath.row)
        cell.configure(with: photo.media.m)
        return cell
    }
}

//MARK: - collection View delegate method
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPhoto = viewModel.photo(at: indexPath.row)
    
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            let detailVC = DetailViewController()
            detailVC.photo = selectedPhoto
            detailVC.photoImage = cell.imageView.image
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


//MARK: - search bar Delegate method

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            viewModel.fetchPhotos()
            return
        }
        viewModel.fetchPhotos(searchTerm: searchText)
    }
}

