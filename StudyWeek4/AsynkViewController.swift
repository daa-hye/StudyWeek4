//
//  AsynkViewController.swift
//  StudyWeek4
//
//  Created by 박다혜 on 2023/08/11.
//

import UIKit

class AsynkViewController: UIViewController {

    @IBOutlet var first: UIImageView!
    @IBOutlet var second: UIImageView!
    @IBOutlet var third: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        first.backgroundColor = .black
        print("1")

        DispatchQueue.main.async {
            print("2")
            self.first.layer.cornerRadius = self.first.frame.width / 2
        }
        print("3")
    }

    //sync async serial concurrent
    //UI Freezing

    @IBAction func buttonClicked(_ sender: UIButton) {

        let url = URL(string: "https://api.nasa.gov/assets/img/general/apod.jpg")!
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
        DispatchQueue.main.async {  //UI같은 요소는 main에서
                self.first.image = UIImage(data: data)
            }
        }
    }

}
