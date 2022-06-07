//
//  Dorm.swift
//  ArchDorm
//
//  Created by MacBook Pro on 05/06/22.
//

import Foundation
import SwiftUI

struct DormData {
    var dormName: String
    var dormAddress: String
    var note: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
