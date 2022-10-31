//
//  APIService.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/10/28.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

enum NetworkError: String {
    case badRequest = "잘못된 요청입니다."
    case unauthorized = "만료된 토큰입니다."
    case forbidden = "요청을 수행할 수 있는 권한이 없습니다."
    case notFound = "요청한 리소스가 존재하지 않습니다."
    case wrong = "우리 쪽에서 문제가 발생했습니다."
}

class APIService {
    
//    static func randomPhoto(completion: @escaping (RandomPhoto?, Int?, Error?) -> Void) {
//        let url = "\(APIKey.randomURL)"
//        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
//
//        //Codable을 사용한다면 swiftyJson 필요없음!
//        AF.request(url, method: .get, headers: header).responseDecodable(of: RandomPhoto.self) { response in
//
//            let statusCode = response.response?.statusCode //상태코드 조건문 처리 해보기!
//            //콜수
//            //랜덤포토
//            switch response.result {
//            case .success(let value): completion(value, statusCode, nil)
//            case .failure(let error): completion(nil, statusCode, error)
//            }
//        }
//    }
    
    static func rxRandomPhoto(disposeBag: DisposeBag, completion: @escaping (RandomPhoto?, Int?, Error?) -> Void) {
        let url = APIKey.randomURL
        request(.get, url, headers: ["Authorization" : APIKey.authorization])
            .validate(statusCode: 200..<300)
            .data()
            .decode(type: RandomPhoto.self, decoder: JSONDecoder())
            .debug()
            .subscribe(onNext: { value in
                completion(value, nil, nil)
            }, onError: { error in
                guard let errors = error.asAFError else { return }
                guard let code = errors.responseCode else { return }
                
                switch code {
                case 400: print(NetworkError.badRequest.rawValue)
                case 401: print(NetworkError.unauthorized.rawValue)
                case 403: print(NetworkError.forbidden.rawValue)
                case 404: print(NetworkError.notFound.rawValue)
                case 500, 503: print(NetworkError.wrong.rawValue)
                default:
                    break
                }
                
                completion(nil, code, error)
            })
            .disposed(by: disposeBag)
    }
    
    private init() { }
}

