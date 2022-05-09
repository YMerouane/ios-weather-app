//
//  HourlyFooter.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class HourlyFooter: TransparentCell, UICollectionViewDelegate {
    
    //MAKR: Static properties
    
    var viewModel: Home.ViewModels.HourlyFooterViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: Subviews
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerCells(HourlyCell.self)
        let hInset = Screen.width * 0.05
        let insets = UIEdgeInsets(top: 0, left: hInset, bottom: 0, right: hInset)
        collectionView.contentInset = insets
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = hInset
            layout.minimumInteritemSpacing = 0
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            
        }
        return collectionView
    }()
    
    //MARK: Other Properties
    //MARK: Life cycle
    override func setup() {
        isUserInteractionEnabled = true//switch back property to allow collection view scrolling
        activateConstraints()
    }
    //MARK:Instance methods
    override func activateConstraints() {
        addSubview(collectionView)
        addSeparator(to: .top, aboveSubview: collectionView)
        addSeparator(to: .bottom, aboveSubview: collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
}
////MARK: DataSource
extension HourlyFooter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.itemViewModels.count ?? 0
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.description(), for: indexPath) as! HourlyCell
        cell.viewModel = viewModel?.itemViewModels[indexPath.item]
        return cell
    }
    
    
}

