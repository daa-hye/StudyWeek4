//
//  ViewController.swift
//  StudyWeek4
//
//  Created by 박다혜 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Movie {
    var title: String
    var release: String
}

class ViewController: UIViewController {

    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var searchBar: UISearchBar!

    var movieList: [Movie] = []
    //codable
    var result: BoxOffice?

    override func viewDidLoad() {
        super.viewDidLoad()

        movieTableView.rowHeight = 60
        movieTableView.delegate = self
        movieTableView.dataSource = self

        indicatorView.isHidden = true

    }

    func callRequest(date: String) {

        indicatorView.startAnimating()
        indicatorView.isHidden = false

        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)"
        AF.request(url, method: .get).validate()
            .responseDecodable(of: BoxOffice.self) { response in
                print(response.value)
                self.result = response.value
            }










//            .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")

//                print("++++++++")
//                let name1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
//                let name2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
//                let name3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
//
//                print(name1, name2, name3)
                //self.movieList.append(contentsOf: [name1, name2, name3])
//
//                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
//                    let movieNm = item["movieNm"].stringValue
//                    let openDt = item["openDt"].stringValue
//
//                    let data = Movie(title: movieNm, release: openDt)
//                    self.movieList.append(data)
//                }
//
//                self.indicatorView.stopAnimating()
//                self.indicatorView.isHidden = true
//                self.movieTableView.reloadData()
//
//            case .failure(let error):
//                print(error)
//            }
//        }
    }

}

extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        movieList.removeAll()
        callRequest(date: searchBar.text!)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result!.boxOfficeResult.dailyBoxOfficeList.count //movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")!
        cell.textLabel?.text = movieList[indexPath.row].title
        cell.detailTextLabel?.text = movieList[indexPath.row].release

        return cell
    }

}
