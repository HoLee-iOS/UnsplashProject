//
//  RandomPhotoViewModel.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/10/28.
//

import Foundation
import RxSwift
import RxCocoa

enum SearchError: Error {
    case noPhoto
    case serverError
}

class RandomPhotoViewModel {
    
    //var photoList: CObservable<RandomPhoto> = CObservable(RandomPhoto(description: "", urls: Urls(thumb: "")))
    var photoList = BehaviorRelay(value: RandomPhoto(description: "", urls: Urls(thumb: "")))
    
    let disposeBag = DisposeBag()
    
//    func requestRandomPhoto() {
//        APIService.randomPhoto { [weak self] photo, statusCode, error in
//
//            guard let statusCode = statusCode, statusCode == 200 else {
//                print(error)
//                return
//            }
//
//            guard let photo = photo else {
//                print(error)
//                return
//            }
//
//            //self?.photoList.value = photo
//            self?.photoList.accept(photo)
//        }
//    }
    
    func requestPhoto() {
        APIService.rxRandomPhoto(disposeBag: disposeBag) { value, statusCode, error in
            
            guard let value = value else {
                print(error)
                return
            }
    
            self.photoList.accept(value)
        } 
    }
}
