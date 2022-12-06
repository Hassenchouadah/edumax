//
//  CourseModel.swift
//  edumax
//
//  Created by user231981 on 11/15/22.
//

import Foundation


struct CourseModel: Codable {
    let _id: String
    let title: String
    let description: String
    let price: String
    let image:String
    let mentor: MentorModel?
}
