//
//  RandomPhotoViewModel.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/10/28.
//

import Foundation

enum SearchError: Error {
    case noPhoto
    case serverError
}


class RandomPhotoViewModel {
    
    var photoList: CObservable<RandomPhoto> = CObservable(RandomPhoto(description: "", urls: Urls(thumb: "")))
    
    func requestRandomPhoto() {
        APIService.randomPhoto { [weak self] photo, statusCode, error in
            
            guard let statusCode = statusCode, statusCode == 200 else {
                print(error)
                return
            }
            
            guard let photo = photo else {
                print(error)
                return
            }
            
            self?.photoList.value = photo
        }
    }
    
}
