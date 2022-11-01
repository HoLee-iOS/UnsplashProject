//
//  RandomPhotoViewController.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/10/28.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Kingfisher

class RandomPhotoViewController: UIViewController {
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤", for: .normal)
        button.tintColor = .green
        button.backgroundColor = .red
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return view
    }()
    
    var viewModel = RandomPhotoViewModel()
    
    let disposeBag = DisposeBag()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, RandomPhoto>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
        configureDataSource()
        
        addAction()
    }
    
    func configureUI() {
        [randomButton, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        randomButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(randomButton.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func addAction() {
        
        randomButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc, value) in
                vc.viewModel.requestPhoto()
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)
        
        viewModel.photoList
            .asDriver()
            .drive(onNext: { [weak self] value in
                var snapshot = NSDiffableDataSourceSnapshot<Int, RandomPhoto>()
                snapshot.appendSections([0])
                snapshot.appendItems([value])
                self?.dataSource.apply(snapshot, animatingDifferences: true)
            })
            .disposed(by: disposeBag)
        
    }
}

extension RandomPhotoViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, RandomPhoto>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.description ?? ""
            DispatchQueue.global().async {
                guard let url = URL(string: itemIdentifier.urls.thumb) else { return }
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 2
            background.strokeColor = .systemGreen
            
            cell.backgroundConfiguration = background
        })
        
        //numberOfItemsInSection, cellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }    
}
