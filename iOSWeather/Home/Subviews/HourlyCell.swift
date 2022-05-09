//
//  HourlyCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class HourlyCell: TransparentCell ,ViewModelRepresentable {
    
    var viewModel: Home.ViewModels.HourlyItemViewModel? {
        didSet {
            
            if let vm = viewModel {
                populateSubviews(with: vm)
            }
        }
    }
    
    func populateSubviews(with viewModel: Home.ViewModels.HourlyItemViewModel) {
        hourLabel.text = viewModel.hour
        weatherImageView.image = UIImage(named: viewModel.iconName)
        temperatureLabel.text = viewModel.temperature
    }
    
  
    //MARK: Life Cycle
    override func setup() {
     
        activateConstraints()
        
    }
    
    override func activateConstraints() {
      
        let sv = UIStackView(arrangedSubviews: [
            hourLabel,
            weatherImageView,
            temperatureLabel
        ])
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sv)
        sv.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(Screen.Home.HourlyFooter.defaultHeight/3)
            make.width.equalTo(weatherImageView.snp.height)
        }
 
  
        
    }
    let hourLabel: UILabel = {
        return $0
    }(UILabel(font: .temperatureLight))
    
    private let temperatureLabel: UILabel = {
        return $0
    }(UILabel(font: .temperatureRegular))
    
    
    private let weatherImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    
}
