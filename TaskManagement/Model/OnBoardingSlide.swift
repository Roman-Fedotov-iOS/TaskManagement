//
//  OnBoardingSlide.swift
//  TaskManagement
//
//  Created by Roman Fedotov on 23.01.2022.
//

import SwiftUI

struct OnBoardingSlide: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
}

let title = "Easy day planning with \nTime Keeper"
let description = "Some small tasks can change all \nLet`s try this habit reight now"

var onBoardingSlides: [OnBoardingSlide] = [
    
    OnBoardingSlide(image: "image1", title: title, description: description),
    OnBoardingSlide(image: "image2", title: title, description: description),
    OnBoardingSlide(image: "image1", title: title, description: description),
    OnBoardingSlide(image: "image2", title: title, description: description),
]
