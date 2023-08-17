//
//  URL+Extension.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/11.
//

import Foundation



extension URL {
    //URL중에서 공통된 부분
    static let baseURL =  "https://dapi.kakao.com/v2/search/"
    
    
    static func makeEndPointString(_ endpoint: String) -> String {
        
        return baseURL + endpoint
            
    }
    
    
    
}
