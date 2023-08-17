//
//  VideoViewController.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/08.
//

struct Video {
    let author: String
    let date: String
    let time: Int
    let thumbnail: String
    let title: String
    let link: String
    
    var contents: String {
        // get {
        return "\(author) | \(time) | \(time)회 \n\(date)"
        // }
    }
    
    
}

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class VideoViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableView: UITableView!
    
    var videoList: [Video] = []
    var page = 1
    var isEnd = false //현재 페이지가 마지막 페이지인지 점검하는 프로퍼티
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.prefetchDataSource = self
        videoTableView.rowHeight = 140
        
        searchBar.delegate = self
        
    }
    
    func callReqest(query: String, page: Int) {
        
        //        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        //        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=10&page=\(page)"
        //        let header: HTTPHeaders = ["Authorization":"\(APIKey.kakaoKey)"]
        //
        //        print(url)
        
        KakaoAPIManager.shared.callReqeust(query: query, type: .video) { json1 in
            //print("============== \(json1)")
            
            for item in json1["documents"].arrayValue {
                let author = item["author"].stringValue
                let date = item["datetime"].stringValue
                let time = item["play_time"].intValue
                let thumbnail = item["thumbnail"].stringValue
                let title = item["title"].stringValue
                let link = item["url"].stringValue
                
                let data = Video(author: author, date: date, time: time, thumbnail: thumbnail, title: title, link: link)
                
                self.videoList.append(data)
            }
            //print(self.videoList)
            self.videoTableView.reloadData()

            
        }
        
    }
    
    
//    AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
//        switch response.result {
//        case .success(let value):
//            let json = JSON(value)
//            print("JSON: \(json)")
//
//            //상태코드 번호
//            print(response.response?.statusCode)
//
//            let statusCode = response.response?.statusCode ?? 500
//
//            if statusCode == 200 {
//
//                self.isEnd = json["meta"]["is_End"].boolValue
//
//                for item in json["documents"].arrayValue {
//
//                    let author = item["author"].stringValue
//                    let date = item["datetime"].stringValue
//                    let time = item["play_time"].intValue
//                    let thumbnail = item["thumbnail"].stringValue
//                    let title = item["title"].stringValue
//                    let link = item["url"].stringValue
//
//                    let data = Video(author: author, date: date, time: time, thumbnail: thumbnail, title: title, link: link)
//
//                    self.videoList.append(data)
//                }
//
//                print(self.videoList)
//                self.videoTableView.reloadData()
//            } else {
//                print("문제발생. 다시 시도해주세요")
//            }
//
//        case .failure(let error):
//            print(error)
//        }
//
//    }
    
}

extension VideoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked (_ searchBar: UISearchBar) {
        
        page = 1 // 새로운 검색어를 위해
        videoList.removeAll()
        
        guard let query = searchBar.text else { return }
        callReqest(query: query, page: page)
    }
    
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    //extension
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell() }
        
        cell.titleLable.text = videoList[indexPath.row].title
        cell.contentLable.text = videoList[indexPath.row].contents
        
        if let url = URL(string: videoList[indexPath.row].thumbnail) {
            cell.thumbnailIamgeView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    //UITableViewDataSourcePrefetching: iOS10이상 사용가능한 프로토콜
    //cellForRowAt 매서드가 호출되기 전에 미리 호출
    
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    // videoList 갯수와 indexPaths.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도    page count
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPaths in indexPaths {
            //indexPaths.row은 인덱스니까 -1개 더 적음
            if videoList.count - 1 == indexPaths.row && page < 15 && !isEnd {
                page += 1
                callReqest(query: searchBar.text!, page: page)
            }
            
            
        }
    }
    
    // 취소 기능: 직접 취소하는 기능을 구현해주어야 함!
    // 스크롤 지나가면 다운로드 받는 데이터를 취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        //print("===========================취소: \(indexPaths)")
    }
    
    
}



