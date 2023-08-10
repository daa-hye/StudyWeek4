//
//  TranslationViewController.swift
//  StudyWeek4
//
//  Created by 박다혜 on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslationViewController: UIViewController {

    @IBOutlet var originalTextView: UITextView!
    @IBOutlet var translateTextView: UITextView!
    @IBOutlet var originalTextField: UITextField!
    @IBOutlet var translateTextField: UITextField!
    @IBOutlet var requestButton: UIButton!

    let pickerView = UIPickerView()
    let langList = Language.allCases

    var pickedLang = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetting()
    }

    @IBAction func requestButtonClicked(_ sender: UIButton) {

        // detect language

        guard let originalText = originalTextView.text else { return }

        let url = "https://openapi.naver.com/v1/papago/detectLangs"

        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naverId,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]

        let parameter: Parameters = [
            "query" : originalText
        ]

        AF.request(url, method: .post, parameters: parameter, headers: header).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let lang = json["langCode"].stringValue
                        self.translate(lang)
                    case .failure(let error):
                        print(error)
                    }
                }

    }

    func translate(_ source: String) {

        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naverId,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]

        let parameter: Parameters = [
            "source" : source,
            "target" : langList[pickedLang].rawValue,
            "text" : originalTextView.text ?? ""
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
                        self.translateTextView.text = data

                    case .failure(let error):
                        print(error)
                    }
                }

    }

}

extension TranslationViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Language.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return langList[row].title
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        translateTextField.text = langList[row].title
        pickedLang = row
    }

}

extension TranslationViewController {

    func initialSetting() {
        originalTextView.text = ""
        translateTextView.text = ""
        translateTextView.isEditable = false
        requestButton.setTitle("번역하기", for: .normal)

        pickerView.delegate = self
        pickerView.dataSource = self

        originalTextField.text = "언어감지"
        originalTextField.isUserInteractionEnabled = false

        translateTextField.inputView = pickerView
        translateTextField.tintColor = .clear
        translateTextField.text = langList[pickedLang].title
    }

}
