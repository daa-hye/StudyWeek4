//
//  ReusableViewProtocol.swift
//  StudyWeek4
//
//  Created by 박다혜 on 2023/08/11.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol {

    static var identifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: ReusableViewProtocol {

    static var identifier: String {
        return String(describing: self)
    }

}
