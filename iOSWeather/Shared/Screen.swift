//
//  Screen.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit

//MARK: Screen dimensions

enum Screen {
    enum Home {
        static func sizeForItemAtSection(_ section: Int) -> CGSize {
            let partialWidth = Screen.width * 0.9
            switch section {
            case 1:
                return CGSize(width: partialWidth , height: (height * 0.08))
            case 2:
                return CGSize(width: partialWidth, height: (height * 0.14))
            case 3:
                return CGSize(width: partialWidth, height: (height * 0.08))
            case 4:
                return CGSize(width: width, height: (height * 0.12))
            default:
                return .zero
            }
        }
        static func minimumLineSpacingForSectionAt(_ section: Int) -> CGFloat {
            return .zero
        }
        static func referenceSizeForHeaderInSection(section: Int) -> CGSize {
            let headerSize = CGSize(width: Screen.width, height: CurrentHeader.defaultHeight)
            return section == 0 ? headerSize : .zero
        }
        static func referenceSizeForFooterInSection(section: Int) -> CGSize {
            let footerSize =  CGSize(width: Screen.width, height: HourlyFooter.defaultHeight)
            return section == 0 ? footerSize : .zero
        }
        enum CurrentHeader {
            static var defaultHeight: CGFloat {
                Screen.height * 0.453
            }
            static var minimumHeight: CGFloat {
                Screen.height * 0.143
            }
        }
        
        enum HourlyFooter {
            static var defaultHeight: CGFloat {
                Screen.height * 0.16
            }
        }
        
        
    }
    
    
    
    
    
    
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    fileprivate static var nativeHeight: CGFloat {
        UIScreen.main.nativeBounds.height
    }
    ///Iphone 5,5c,5s,6,6s,SE1,SE2,7,8 screen size
    static var isTiny: Bool {
        return (1134...1136).contains(Screen.nativeHeight)
    }
}


