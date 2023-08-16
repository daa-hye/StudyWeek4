//
//  VideoViewController.swift
//  StudyWeek4
//
//  Created by 박다혜 on 2023/08/08.
//

import UIKit
import Alamofire
import Kingfisher

struct Video {
    let author: String
    let date: String
    let playTime: Int
    let thumbnail: String
    let title: String
    let link: String

    var contents: String {
        return "\(author) | \(playTime)회\n\(date)"
    }

}

class VideoViewController: UIViewController {


    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableView: UITableView!
    
    var videoList: [Video] = []
    var page = 1
    var isEnd = false

    override func viewDidLoad() {
        super.viewDidLoad()

        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.prefetchDataSource = self
        videoTableView.rowHeight = 140

        searchBar.delegate = self

    }

    func callRequest(query: String, page: Int) {

        KakaoAPIManager.shared.callRequest(type: .video, query: query) { videoData in
            let result = videoData.documents
            for item in result {
                let video = Video(author: item.author, date: item.datetime, playTime: item.playTime, thumbnail: item.thumbnail, title: item.title, link: item.url)
                self.videoList.append(video)
            }
            self.videoTableView.reloadData()
        }
    }
}

extension VideoViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        page = 1
        videoList.removeAll()

        guard let text = searchBar.text else { return }
        callRequest(query: text, page: page)
    }

}

//UITableViewDataSourcePrefetching : iOS 10이상 사용 가능한 프로토콜, cellForRoewAt 메서드가 호출되기 전에 미리 호출됨
extension VideoViewController : UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell() }

        cell.titleLabel.text = videoList[indexPath.row].title
        cell.contentLabel.text = videoList[indexPath.row].contents

        if let url = URL(string: videoList[indexPath.row].thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }

        return cell
    }

    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    //videoList 갯수와 indexPath.row 위치를  비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
    //page count
    //
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            if videoList.count - 1 == indexPath.row && page < 15 && isEnd != true {
                page += 1
                callRequest(query: searchBar.text!, page: page)
            }
        }
    }

    //취소 기능 : 직접 취소하는 기능을 구현해주어야 함
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("=====취소 : \(indexPaths)")
    }

}
