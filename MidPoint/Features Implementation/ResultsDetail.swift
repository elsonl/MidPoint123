//
//  ResultsDetail.swift
//  MidPoint
//
//  Created by Elson Lin on 3/12/22.
//

import Foundation

class Zoom : ObservableObject{
    @Published var currentZoom : Float = 1.0
    
    let id = UUID()
}
