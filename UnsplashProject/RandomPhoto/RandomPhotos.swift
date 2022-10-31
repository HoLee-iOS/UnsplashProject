//
//  RandomPhotos.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/10/28.
//

import Foundation
import UIKit

struct RandomPhoto: Codable, Hashable {
    let description: String?
    let urls: Urls
}

struct Urls: Codable, Hashable {
    let thumb: String
}



