//
//  TutorialView.swift
//  MidPoint
//
//  Created by Andy Sun (student LM) on 4/27/22.
//

import SwiftUI

struct TutorialView: View {
    
    var tutorial : [String] = ["Welcome to Midpoint!", "Tap on the boxes to type in your locations", "Then press search! It's that easy!", "The information for points of interest near the middle is shown at the bottom", ""]
    @State var stage : Int = 0
    @Binding var tutorialOpen : Bool
    
    var body: some View {
        VStack{
            Text(tutorial[stage])
            Button(action: {/*advance stage by one*/
                if(stage<3){
                    stage+=1
                }else{
                    tutorialOpen.toggle()
                }
                
                
            }, label :{
                VStack{
                if(stage == 1){
                    VStack{
                        HStack{
                            Image(systemName: "magnifyingglass").foregroundColor(Color.gray) .font(Font.system(size: 30, weight: .semibold))
                            TextField("Example", text: Binding.constant("")).foregroundColor(Color.black).background(Color(.systemGray4)).textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        HStack{
                            Image(systemName: "magnifyingglass").foregroundColor(Color.gray) .font(Font.system(size: 30, weight: .semibold))
                            TextField("Example", text: Binding.constant("")).foregroundColor(Color.black).background(Color(.systemGray4)).textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                    }
                }
                    Text("Next")
                }
            })
            
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

