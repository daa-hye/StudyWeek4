//
//  TranslateAPIManager.swift
//  StudyWeek4
//
//  Created by 박다혜 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class TranslateAPIManager {

    static let shared = TranslateAPIManager()

    private init() { }

    func callRequest(text: String, resultString: @escaping (String) -> Void) {

        let url = EndPoint.translate.url
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naverId,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]

        let parameter: Parameters = [
            "source" : "ko",
            "target" : "en",
            "text" : text
        ]

        print(parameter)

        AF.request(url, method: .post, parameters: parameter, headers: header)
            .validate()
            .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print("JSON: \(json)")

                        let data = json["message"]["result"]["translatedText"].stringValue
                        resultString(data)

                    case .failure(let error):
                        print(error)
                    }
                }

    }
}
