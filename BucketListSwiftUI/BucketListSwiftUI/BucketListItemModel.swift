//
//  BucketListItemModel.swift
//  BucketListSwiftUI
//
//  Created by Александр Павелко on 30.09.2023.
//

import Foundation

struct BucketListItemModel: Identifiable, Equatable, Encodable, Decodable {
    var name: String
    var id = UUID()
    var isComplited: Bool = false
}
