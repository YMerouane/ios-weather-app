//
//  TodayCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class TodayCell: TransparentCell, ViewModelRepresentable {
    
    func populateSubviews(with viewModel: Home.ViewModels.TodayCellViewModel) {
        todayTxtView.text = viewModel.overview
    }
    
    
    var viewModel: Home.ViewModels.TodayCellViewModel? {
        didSet {
            if let vm = viewModel {
                populateSubviews(with: vm)
            }
            
        }
    }
    
    //MARK: Subviews
    private let todayTxtView: UITextView = {
        $0.textAlignment = .left
        $0.font = .temperatureRegular
        $0.textColor = .weatherWhite
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isUserInteractionEnabled = false
        $0.textContainerInset = .zero
        $0.textContainer.maximumNumberOfLines = 4
        $0.textContainer.lineFragmentPadding = 0
        $0.textContainer.lineBreakMode = .byWordWrapping
        return $0
    }(UITextView())
    //MARK: Life cycle
    override func setup() {
        activateConstraints()
        
    }
    //MARK: Instance methods
    override func activateConstraints() {
        addSubview(todayTxtView)
        addSeparator(to: .top, aboveSubview: todayTxtView)
        todayTxtView.snp.makeConstraints { make in
            make.centerY.leading.trailing.equalToSuperview()
        }
        
        
    }
    
    
}
