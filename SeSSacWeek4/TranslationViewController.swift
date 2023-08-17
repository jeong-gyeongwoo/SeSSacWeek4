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
    
    var langCode = ""
    let header: HTTPHeaders = [
        "X-Naver-Client-Id": "\(APIKey.naverClientId)",
        "X-Naver-Client-Secret": "\(APIKey.naverClientPw)"
    ]
    
    //  let helper = UserDefaultsHelper()
    // static을 통해 초기화 필요없게 이후 접근제어자
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults.standard.set("ads",forkey: "nickname")
        //UserDefaults.standard.set(33,forkey: "age")
        
        UserDefaultsHelper.standard.nickname = "asd"
        
        //UserDefaults.standard.String(forkey: "nickname")
        //UserDefaults.standard.integer(forkey: "age")
        
        // 인스턴스 통해 접근
        // helper.nickname
        // helper.age
        // helper.nickname = "sada"
        
        
        //originalTextView.text = UserDefaults.standard.nickname
        
        
        originalTextView.text = ""
        translateTextView.text = ""
        translateTextView.isEditable = false
        
    }
    
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        //        let header: HTTPHeaders = [
        //            "X-Naver-Client-Id": "\(APIKey.naverClientId)",
        //            "X-Naver-Client-Secret": "\(APIKey.naverClientPw)"
        //        ]
        // var langCode = ""
        
        let query = self.originalTextView.text ?? "nil값입니다."
        let url1 = "https://openapi.naver.com/v1/papago/detectLangs"
        let parameters1: Parameters = [
            "query": query
        ]
        
        
        
        
        AF.request(url1, method: .post, parameters: parameters1, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.langCode = json["langCode"].stringValue
                //print(langCode,"======")
                self.translateTextView.text = "\(self.langCode)"
                self.translateButtonClicked()
                
            case.failure(let error):
                print(error)
            }
        }
        
        
        // print(langCode,"aaaaaaaaaaaa")
        // print(type(of: langCode),"bbbbbbbbbbbb")
        
    }
    
    
    
    
    func translateButtonClicked() {
        
        
        TranslateAPIManager.shared.callRequest(text: originalTextView.text ?? "") { result in
            self.translateTextView.text = result
        }
        
        
        
//
//        let url = "https://openapi.naver.com/v1/papago/n2mt"
//        var parameters: Parameters = [
//            "source": "\(langCode)",
//            "target": "en",
//            "text": self.originalTextView.text ?? "nil값입니다."
//
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//
//                let json = JSON(value)
//                // print("=================","아래는 번역 API" )
//                // print("JSON: \(json)")
//
//                let data = json["message"]["result"]["translatedText"].stringValue
//                self.translateTextView.text = data
//
//
//
//            case .failure(let error):
//                print(error)
//            }
//
//
//        }
//
        
    }
    
}
