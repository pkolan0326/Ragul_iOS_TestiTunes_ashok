//
//  Constants.swift
//  TestiTunes
//
//  Created by Ragul kts on 27/04/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
enum Methods: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

struct Constants {
    static var baseUrl = "https://rss.itunes.apple.com/api/v1"
}

extension Parameters {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}
