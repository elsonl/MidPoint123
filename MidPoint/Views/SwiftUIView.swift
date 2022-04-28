//
//  SwiftUIView.swift
//  MidPoint
//
//  Created by Andy Sun (student LM) on 4/27/22.
//
import SwiftUI

struct SwiftUIView: View {
    @Binding var tutorialOpen : Bool
    @Binding var address1 : String
    @Binding var address2 : String
    @Binding var delegatePlaceID : String
    var body: some View {
  
        TabView{
            ContentView(tutorialOpen: $tutorialOpen, address1: $address1, address2: $address2, delegatePlaceID: $delegatePlaceID).onAppear{
                UITabBar.appearance().backgroundColor = UIColor(Color.BackgroundColor)
                UITabBar.appearance().unselectedItemTintColor = UIColor(Color.black)

            } .tabItem{
                Label("Home", systemImage: "house")
            }
            
            
            TutorialView(tutorialOpen: $tutorialOpen).onAppear{
                tutorialOpen = true
                UITabBar.appearance().backgroundColor = UIColor(Color.BackgroundColor)
                UITabBar.appearance().unselectedItemTintColor = UIColor(Color.black)
            } .tabItem{
                Label("Info", systemImage: "info.circle")
            }
        }.accentColor(.red).background(Color.BackgroundColor).onAppear{
           print("tabview appear")
     
            UITabBar.appearance().backgroundColor = UIColor(Color.BackgroundColor)
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.black)
    
        }
    }
}
