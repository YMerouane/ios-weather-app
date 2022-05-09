//
//  DailyCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit

final class DailyCell: TransparentCell {
    
    var viewModel: Home.ViewModels.DailyCellViewModel? {
        didSet {
            if let vm = viewModel {
                populateSubviews(with: vm)
            }
        }
    }
    
    func populateSubviews(with viewModel: Home.ViewModels.DailyCellViewModel) {
        dayLabel.text = viewModel.day
        weatherImageView.image = UIImage(named: viewModel.weatherIcon)
        percentageLabel.text = viewModel.probability
        maxTemperatureLabel.text = viewModel.maxTemperature
        minTemperatureLabel.text = viewModel.minTemperature
        
    }
    
    
    //MARK: Subviews
    let dayLabel: UILabel = {
        $0.font = .dayTitle
        $0.textColor = .weatherWhite
        return $0
    }(UILabel())
    
    private let maxTemperatureLabel: UILabel = {
        return $0
    }(UILabel(font: .temperatureRegular))
    
    private let minTemperatureLabel: UILabel = {
        return $0
    }(UILabel(transparent: true, alignment: .center, font: .temperatureLight))
    
    private let weatherImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        
        return $0
    }(UIImageView())
    
    private let percentageLabel: UILabel = {
        $0.textColor = .percentage
        return $0
    }(UILabel(font: .extendedInfoTitle))
    
    private lazy var weatherImagePercentageStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        return $0
    }(UIStackView(arrangedSubviews: [weatherImageView,percentageLabel]))
    private lazy var temperatureRangeStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .trailing
        $0.distribution = .fillEqually
        $0.spacing = 0
        return $0
    }(UIStackView(arrangedSubviews:[maxTemperatureLabel,minTemperatureLabel]))
    
    //MARK: life Cycle
    override func setup() {
        activateConstraints()
    }
    private lazy var stack: UIStackView = {
        $0.addArrangedSubview(dayLabel)
        $0.addArrangedSubview(weatherImagePercentageStack)
        $0.addArrangedSubview(temperatureRangeStack)
        $0.axis = .horizontal
        $0.spacing = 0
        $0.alignment = .center
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    override func activateConstraints() {
        addMultipleSubviews(
            stack
        )
        stack.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
            
            
        }
        
    }
}
