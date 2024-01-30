//
//  Helpers.swift
//  
//
//  Created by jaime.gutierrez.m on 13/5/23.
//

import Foundation

public func DLog(_ log: String) {
#if DEBUG
    print(log)
#endif
}

extension URLRequest {
    
    var cURL: String {
        guard let method = httpMethod?.uppercased(), let url = url else {
            return ""
        }
        
        var curl = "curl -X " + method.uppercased()
        curl += " " + url.absoluteString
        if let headers = allHTTPHeaderFields {
            for (k, v) in headers {
                curl += " \\\n -H '\(k): \(v)'"
            }
        }
        
        if method != "GET", let body = httpBody {
            do {
                let json = try JSONSerialization.jsonObject(with: body, options: .allowFragments)
                let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                if let strJSON = String(data: data, encoding: .utf8) {
                    curl += " \\\n -d '\(strJSON.replacingOccurrences(of: "\n", with: " "))'"
                }
            } catch {
                print(error.localizedDescription)
                if let data = String(data: body, encoding: .utf8) {
                    curl += " \\\n -d '\(data)'"
                }
            }
        }
        return curl
    }
}
