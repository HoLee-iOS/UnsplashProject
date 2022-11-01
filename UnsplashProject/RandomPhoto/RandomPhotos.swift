//
//  RandomPhotos.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/10/28.
//

import Foundation

struct RandomPhoto: Codable, Hashable {
    let description: String?
    let urls: Urls
}

struct Urls: Codable, Hashable {
    let thumb: String
}

//struct RandomSection {
//    var items: [Item]
//    
//    init(items: [RandomPhoto]) {
//        self.items = items
//    }
//}
//
//extension RandomSection: SectionModelType {
//    
//    typealias Item = RandomPhoto
//    
//    init(original: RandomSection, items: [Item]) {
//        self = original
//        self.items = items
//    }
//    
//}
