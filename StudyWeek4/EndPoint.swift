//
//  EndPoint.swift
//  StudyWeek4
//
//  Created by 박다혜 on 2023/08/11.
//

import Foundation

enum EndPoint {
    case blog
    case cafe
    case video
    case translate
    case detectLang

    var url: String {
        switch self {
        case .blog: return ""
        case .cafe : return ""
        case . video : return URL.makeKakaoEndPointString("vclip?query=")
        case .translate : return URL.makePapagoEndPointString("n2mt")
        case .detectLang : return URL.makePapagoEndPointString("detectLangs")
        }
    }
}
