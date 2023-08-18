//
//  VideoViewController.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/08.
//

import UIKit
import Alamofire
import Kingfisher

class VideoViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableView: UITableView!
    
    var videoList: Info = Info(documents: [], meta: Meta(isEnd: false, pageableCount: 1, totalCount: 1))
    // var isEnd = false //현재 페이지가 마지막 페이지인지 점검하는 프로퍼티
    var pageCount = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.prefetchDataSource = self
        videoTableView.rowHeight = 140
        
        searchBar.delegate = self
        
        // videoTableView.reloadData()
    }
    
    
}

extension VideoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked (_ searchBar: UISearchBar) {
        
        // page = 1 // 새로운 검색어를 위해
        //videoList.removeAll() -> 덮어쓰니까 여기선 x
        
        guard let query = searchBar.text else { return }
        KakaoAPIManager.shared.callReqeust(query: query, type: .video, page: 1) { data in
            self.videoList = data
            //print(self.videoList)
            self.videoTableView.reloadData()
            
        }
    }
    
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.documents.count
    }
    
    //extension
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell() }
        
        let date =  videoList.documents[indexPath.row].datetime
        let playMinute = (videoList.documents[indexPath.row].playTime) / 60
        let playSecond = (videoList.documents[indexPath.row].playTime) % 60
        
        cell.titleLable.text = videoList.documents[indexPath.row].title
        cell.contentLable.text = "\(date) | \(playMinute)분 \(playSecond)초"
        
        if let url = URL(string: videoList.documents[indexPath.row].thumbnail) {
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
            // indexPaths.row은 인덱스니까 -1개 더 적음
            if videoList.documents.count - 1 == indexPaths.row && pageCount < videoList.meta.pageableCount && !(videoList.meta.isEnd) {
                print(pageCount)
                //print(videoList.documents.count)
                //print(videoList.meta.isEnd)
                pageCount += 1
                //print(pageCount)
                KakaoAPIManager.shared.callReqeust(query: searchBar.text!, type: .video, page: pageCount) { data in
                    print(data)
                    //self.videoList = data
                    self.videoList.documents.append(contentsOf: data.documents)
                    //print(self.videoList.documents.count)
                    self.videoTableView.reloadData()
                }
            }
            
            
        }
        
        
    }
    
    // 취소 기능: 직접 취소하는 기능을 구현해주어야 함!
    // 스크롤 지나가면 다운로드 받는 데이터를 취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        //print("===========================취소: \(indexPaths)")
    }
    
    
}

