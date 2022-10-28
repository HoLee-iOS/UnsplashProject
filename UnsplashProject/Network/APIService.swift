//
//  APIService.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/10/28.
//

import Foundation
import Alamofire

class APIService {
    
    static func randomPhoto(completion: @escaping (RandomPhoto?, Int?, Error?) -> Void) {
        let url = "\(APIKey.randomURL)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        //Codable을 사용한다면 swiftyJson 필요없음!
        AF.request(url, method: .get, headers: header).responseDecodable(of: RandomPhoto.self) { response in
            
            let statusCode = response.response?.statusCode //상태코드 조건문 처리 해보기!
            //콜수
            //랜덤포토
            switch response.result {
            case .success(let value): completion(value, statusCode, nil)
            case .failure(let error): completion(nil, statusCode, error)
            }
        }
    }
    
    private init() { }
}

