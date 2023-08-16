//
//  BoxOfficeData.swift
//  StudyWeek4
//
//  Created by 박다혜 on 2023/08/14.
//

import Foundation

// MARK: - Welcome
struct BoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
    let showRange, boxofficeType: String
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let scrnCnt, movieCD, salesChange, audiInten: String
    let rnum, audiCnt, movieNm, rank: String
    let showCnt, audiChange, rankInten: String
    let rankOldAndNew: RankOldAndNew
    let salesAmt, salesInten, salesAcc, audiAcc: String
    let salesShare, openDt: String

    enum CodingKeys: String, CodingKey {
        case scrnCnt
        case movieCD = "movieCd"
        case salesChange, audiInten, rnum, audiCnt, movieNm, rank, showCnt, audiChange, rankInten, rankOldAndNew, salesAmt, salesInten, salesAcc, audiAcc, salesShare, openDt
    }
}

enum RankOldAndNew: String, Codable {
    case old = "OLD"
}
