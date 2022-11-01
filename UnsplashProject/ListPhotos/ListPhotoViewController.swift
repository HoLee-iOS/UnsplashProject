//
//  ListPhotoViewController.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/11/01.
//

import Foundation
import UIKit
import SnapKit

class ListPhotoViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        //view.collectionViewLayout = createLayout()
        return view
    }()
    
    var viewModel = ListPhotoViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, ListPhoto>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
        configureDataSource()
        bindData()        
    }
    
    func configureUI() {
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindData() {
        viewModel.requestList()
        
        viewModel.photoList
            .bind { [weak self] list in
                var snapshot = NSDiffableDataSourceSnapshot<Int, ListPhoto>()
                snapshot.appendSections([0])
                snapshot.appendItems(list)
                self?.dataSource.apply(snapshot)
            }
    }
}

extension ListPhotoViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ListPhoto> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}
