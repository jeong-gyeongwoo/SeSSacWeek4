//
//  ReusableViewProtocol.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/11.
//

import UIKit

// 뷰컨트롤러 마다 id를 프로토콜로
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



