//
//  ListPhotoViewModel.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/11/01.
//

import Foundation

class ListPhotoViewModel {
    
    var photoList: CObservable<[ListPhoto]> = CObservable([])
    
    func requestList() {
        URLSession.request(codable: [ListPhoto].self, endpoint: APIService.requestPhoto()) { value, error in
            guard let value = value else { return }
            
            self.photoList.value = value
        }
    }
}
