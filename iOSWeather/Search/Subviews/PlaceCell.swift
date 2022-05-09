//
//  CityCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//

import UIKit

class PlaceCell: UITableViewCell, ViewModelRepresentable {
        
    var viewModel: Search.ViewModels.PlaceViewModel? {
        didSet {
            if let viewModel = viewModel {
                populateSubviews(with: viewModel)
            }
        }
    }

    func populateSubviews(with viewModel: Search.ViewModels.PlaceViewModel) {
        nameLabel.text = viewModel.name
    }
    
    let nameLabel: UILabel = {
        $0.numberOfLines = 0
        $0.textColor = .white
        return $0
    }(UILabel(alignment: .left, font: .place ))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        backgroundColor = .clear
        addSeparator(to: .bottom, aboveSubview: self)
        activateConstraints()
       
    }
    
    private func activateConstraints() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.trailing.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
