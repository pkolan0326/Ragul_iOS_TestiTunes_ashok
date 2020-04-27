//
//  APIList.swift
//  TestiTunes
//
//  Created by Ragul kts on 27/04/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
enum APIList: String {
    
    case getTop100
   
    
    var apiString:String{
        switch self {
        case .getTop100:
            return "\(Constants.baseUrl)/us/apple-music/top-albums/all/100/explicit.json"
      
        }
    }
    
}
