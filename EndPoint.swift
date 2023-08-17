//
//  EndPoint.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/11.
//

import Foundation

enum Endpoint {
    case blog
    case cafe
    case video
    
    var requestURL: String {
        switch self {
        case .blog: return URL.makeEndPointString("blog?query=")
        case .cafe: return URL.makeEndPointString("cafe?query=")
        case .video: return URL.makeEndPointString("vclip?query=")
        }
    }
}


    /*
     "https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=10&page=\(page)"
     
     */
