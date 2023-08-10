//
//  Language.swift
//  StudyWeek4
//
//  Created by 박다혜 on 2023/08/10.
//

import Foundation

enum Language: String, CaseIterable {

    case ko
    case en
    case ja
    case zhc = "zh-CN"
    case zht = "zh-TW"

    var title: String {
        switch self {
        case .ko:
            return "한국어"
        case .en:
            return "영어"
        case .ja:
            return "일본어"
        case .zhc:
            return "중국어(간체)"
        case .zht:
            return "중국어(번체)"
        }
    }
}

