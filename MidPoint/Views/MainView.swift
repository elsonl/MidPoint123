//
//  MainView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 4/27/22.
//

import SwiftUI

struct MainView: View {
//    @Binding var tutorialOpen : Bool
//    @Binding var address1 : String
//    @Binding var address2 : String
//    @Binding var delegatePlaceID : String
    @State var tutorialOpen : Bool = false
    @State var address1 : String
    @State var address2: String
    @State var delegatePlaceID : String = "nothing yet"
    
    var body: some View {
        SwiftUIView(tutorialOpen: $tutorialOpen, address1: $address1, address2: $address2, delegatePlaceID: $delegatePlaceID)
    }
}
