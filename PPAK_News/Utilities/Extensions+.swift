//
//  Extensions+.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/06.
//

import UIKit

extension String {
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let convertDate = formatter.date(from: self)
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "yyyy.MM.dd a hh:mm"
        stringFormatter.locale = Locale(identifier: "en")
        
        return stringFormatter.string(from: convertDate!)
    }
}


