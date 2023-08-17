//
//  TranslateAPLManager.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/11.
//

import Foundation
import SwiftyJSON
import Alamofire

class TranslateAPIManager {
    
    
    static let shared = TranslateAPIManager()
    
    private init() {}
    
    func callRequest(text: String, resultString: @escaping (String) -> Void) {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "\(APIKey.naverClientId)",
            "X-Naver-Client-Secret": "\(APIKey.naverClientPw)"
        ]
        var parameters: Parameters = [
            "source": "ko",
            "target": "en",
            "text": text
            
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                let data = json["message"]["result"]["translatedText"].stringValue
                resultString(data)
                
                
                
            case .failure(let error):
                print(error)
            }
            
            
        }
        
        
        
        
        
    }
    
}
