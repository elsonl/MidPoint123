//
//  TutorialView.swift
//  MidPoint
//
//  Created by Andy Sun (student LM) on 4/27/22.
//
import SwiftUI

struct customViewModifier2: ViewModifier {
    var roundedCornes: CGFloat
    var startColor: Color
    var endColor: Color
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                        .stroke(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5))
            .font(.custom("Open Sans", size: 20))
            
            .shadow(radius: 10)
    }
}
struct TutorialView: View {
    
    var tutorial : [String] = ["Welcome to Midpoint!", "Tap on the boxes to type in your locations", "Then press search! It's that easy!"]
    @State var stage : Int = 0
    @Binding var tutorialOpen : Bool
    
    var body: some View {
        VStack{
            Text(tutorial[stage]).font(Font.system(size: 18, weight: .bold))
            Spacer().frame(height: 35)
            Button(action: {/*advance stage by one*/
                if(stage<2){
                    stage+=1
                }else{
                    stage = 0
                }
                
                
            }, label :{
                VStack{
                if(stage == 1){
                    VStack{
                        HStack{
                            Image(systemName: "magnifyingglass").foregroundColor(Color.black) .font(Font.system(size: 30, weight: .semibold))
                            TextField("Example", text: Binding.constant(""))
                        } .modifier(customViewModifier2(roundedCornes: 6, startColor: .gray, endColor: .BackgroundColor, textColor: .black)).frame(width: 375, alignment: .trailing)
                        HStack{
                            Image(systemName: "magnifyingglass").foregroundColor(Color.black) .font(Font.system(size: 30, weight: .semibold))
                            TextField("Example", text: Binding.constant(""))
                        }.modifier(customViewModifier2(roundedCornes: 6, startColor: .gray, endColor: .BackgroundColor, textColor: .black)).frame(width: 375, alignment: .trailing)
                        
                    }
                }
                    Spacer().frame(height: 35)
                    Text("Next").padding().background(Color.gray).clipShape(Capsule()).font(Font.system(size: 16, weight: .bold)).foregroundColor(.black)
                }
            })
            
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
