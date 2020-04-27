//
//  APICall.swift
//  TestiTunes
//
//  Created by Ragul kts on 17/04/20.
//  Copyright © 2020 Ragul kts. All rights reserved.
//


import UIKit
//https://rss.itunes.apple.com/en-us
typealias Parameters = [String:Any]

class APICall: NSObject {
    static let instance = APICall()
    func performAPIcallWith<T:Decodable>(type:T.Type, url:APIList, method:Methods, param: Parameters,completion: @escaping ((_ success: T?,_ error: String?)->Void)){
        var finalUrl = ""
        if method == .get {
            finalUrl = url.apiString + "?" + param.queryString
        }else{
            finalUrl = url.apiString
        }
        guard let todosURL = URL(string: finalUrl) else {
            completion(nil,"Error: cannot create URL")
            return
        }

        var urlRequest = URLRequest(url: todosURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        
        if method == .post {
            urlRequest.httpBody = param.queryString.data(using: .utf8)
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                completion(nil,error?.localizedDescription)
                return
            }
            guard let responseData = data else {
                completion(nil,"Error: did not receive data")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any]
                print("\(url.apiString) \n\n \(json)")
                let genericModel = try JSONDecoder().decode(type, from: responseData)
                completion(genericModel, nil)
            } catch (let parseError) {
                print(parseError)
                completion(nil,parseError.localizedDescription)
                return
            }
        }
        task.resume()
    }
//    func performAPIcallWith(urlStr: String,
//                            methodName method: Methods,
//                            json: [AnyHashable: Any]?,completion: @escaping (Result<ITunesAlbum, Error>) -> Void)
//    {
//        DispatchQueue.main.async {
//            print("loading......")
//        }
//        var urlString = ""
//        let  methodHTTP = method.rawValue
//        urlString = SERVERURL + urlStr
//        if let url = URL.init(string: urlString){
//            var request = URLRequest(url: url)
//            request.httpMethod = methodHTTP
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            if let json = json {
//                let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//                request.httpBody = data
//            }
//
//            //Create Session.
//            let config = URLSessionConfiguration.default
//            let session = URLSession.init(configuration: config)
//            let task = session.dataTask(with: request) { (data, response, error) in
//                DispatchQueue.main.async {
//                    print("remove loading ...")
//                }
//                // check error and data.
//                guard error == nil && data != nil else {
//                    print("error loading .... sent error")
//                    let result = APIResult()
//                    result.data = data
//                    result.response = response
//                    result.error = error
//                    if let action = self.failureAPI
//                    {
//                        action(result)
//                    }
//                    // Delegate
//                    if let del = self.delegate, del.serverSuccess?(result: result) != nil
//                    {
//                        DispatchQueue.main.async {
//                            completion(.success(result ?? []))
//                        }
//                        del.serverSuccess?(result: result)
//                    }
//                    return
//                }
//                // check for response.
//                let res = response as? HTTPURLResponse
//                if res?.statusCode == 201 || res?.statusCode == 200{
//                    //success(data, response)
//                    print("success .... sent success")
//                    let result = APIResult()
//                    result.data = data
//                    result.response = response
//                    result.error = error
//                    if let action = self.successAPI
//                    {
//                        action(result)
//                    }
//                    if let del = self.delegate, del.serverSuccess?(result: result) != nil
//                    {
//                        del.serverSuccess?(result: result)
//                    }
//                }   else{
//                    print("error loading .... sent error")
//                    let result = APIResult()
//                    result.data = data
//                    result.response = response
//                    result.error = error
//                    if let action = self.failureAPI
//                    {
//                        action(result)
//                    }
//                    if let del = self.delegate, del.serverFail?(result: result) != nil
//                    {
//                        del.serverFail?(result: result)
//                    }
//                }
//            }
//            // Perform API Call.
//            task.resume()
//        }
//        else {
//            let result = APIResult()
//            result.data = nil
//            result.response = nil
//            result.error = nil
//            if let action = self.failureAPI
//            {
//                action(result)
//            }
//            if let del = self.delegate, del.serverFail?(result: result) != nil
//            {
//                del.serverFail?(result: result)
//            }
//
//        }
//    }
}

