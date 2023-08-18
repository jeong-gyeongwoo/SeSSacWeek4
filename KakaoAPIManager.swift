//
//  KakaoAPIManager.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/11.
//

import UIKit
import Alamofire
//import SwiftyJSON

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() { }
    
    let header: HTTPHeaders = ["Authorization":"\(APIKey.kakaoKey)"]
    
    func callReqeust(query: String, type: Endpoint, page:Int, success: @escaping (Info) -> Void ) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.requestURL + text + "&page=\(page)"

        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Info.self){ response in
                switch response.result {
                case .success(let value):
                    success(value)
                    //print(url)
                case .failure(let error):
                    print(error)
                }
            }
        
        
    }
    
    
   // let url = Endpoint.video.requestURL
    
    
    
    
}
