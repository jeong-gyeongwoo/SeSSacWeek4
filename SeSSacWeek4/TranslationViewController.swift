//
//  TranslationViewController.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslationViewController: UIViewController {

    @IBOutlet var translateTextView: UITextView!
    @IBOutlet var requestButton: UIButton!
    @IBOutlet var originalTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        originalTextView.text = ""
        translateTextView.text = ""
        translateTextView.isEditable = false
        
    }
    

    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "\(APIKey.naverClientId)",
            "X-Naver-Client-Secret": "\(APIKey.naverClientPw)"
        ]
        var langCode = ""
        let query = originalTextView.text ?? "nil값입니다."
        print(query)
        print(type(of: query))
        let url1 = "https://openapi.naver.com/v1/papago/detectLangs?query=\(query)"
       
        AF.request(url1, method: .post, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                //langCode = json["langCode"].stringValue
                //print(langCode)
                
            case .failure(let error):
                print(error)
            }
        }
        
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let parameters: Parameters = [
            "source": "ko",     //"\(langCode)",
            "target": "en",
            "text": originalTextView.text ?? "오류"
            
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("=================","아래는 번역 API" )
                print("JSON: \(json)")
                
                let data = json["message"]["result"]["translatedText"].stringValue
                self.translateTextView.text = data
                
                
                
            case .failure(let error):
                print(error)
            }
        }

        
        
        
    }
    
    
    
    
}
