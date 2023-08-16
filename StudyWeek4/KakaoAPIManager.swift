//
//  KakaoAPIManager.swift
//  StudyWeek4
//
//  Created by 박다혜 on 2023/08/11.
//

import Foundation
import Alamofire

class KakaoAPIManager {

    static let shared = KakaoAPIManager()

    private init() {  }

    let header: HTTPHeaders = ["Authorization" : "\(APIKey.kakaoAK)"]

    func callRequest(type: EndPoint, query: String, completionHandler: @escaping (VideoData) -> () ) {

        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.url + text
        //"https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=10&page=\(page)"

        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: VideoData.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
