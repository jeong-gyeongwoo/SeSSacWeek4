//
//  BoxOfficeData.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/14.
//

import Foundation

// Quicktype으로 가져옴

// MARK: - Welcome
struct BoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
    let boxofficeType: String
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let audiChange, salesAcc, salesShare, audiCnt: String
    let salesAmt, audiAcc, audiInten, rankInten: String
    let scrnCnt, openDt: String
    let rankOldAndNew: RankOldAndNew
    let salesInten, salesChange, rank, rnum: String
    let movieCD, movieNm, showCnt: String

    enum CodingKeys: String, CodingKey {
        case audiChange, salesAcc, salesShare, audiCnt, salesAmt, audiAcc, audiInten, rankInten, scrnCnt, openDt, rankOldAndNew, salesInten, salesChange, rank, rnum
        case movieCD = "movieCd"
        case movieNm, showCnt
    }
}

enum RankOldAndNew: String, Codable {
    case old = "OLD"
}
