//
//  RSPageController.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/29/22.
//

import SwiftUI

struct RSPageController: View {

    @Binding var selectedPage: Int

    var pages: Int
    var circleDiameter: CGFloat
    var circleMargin: CGFloat
    
    let buttonGradient = [ Color(hex: "4000FF"), Color(hex: "b452b4") ]

    private var circleRadius: CGFloat { circleDiameter / 2}
    private var pageIndex: CGFloat { CGFloat(selectedPage - 1) }

    private var currentPosition: CGFloat {
        // Get the first circle position
        let stackWidth = circleDiameter * CGFloat(pages) + circleMargin * CGFloat(pages - 1)
        let halfStackWidth = stackWidth / 2
        let iniPosition = -halfStackWidth + circleRadius

        // Calculate the distance to get the next circle
        let distanceToNextPoint = circleDiameter + circleMargin

        // Use the pageIndex to get the current position
        return iniPosition + (pageIndex * distanceToNextPoint)
    }

    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .borderOverlay(lineWidth: 3, cornerRadius: 16)
            
            // Total number of pages
            HStack(spacing: 8) {

                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        //.stroke(Color.black, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .gradientBorder(colors: buttonGradient, cornerRadius: 12, lineWidth: 3)
                    .foregroundColor(.white)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "gear")
                            .fontWeight(.heavy)
                            .frame(width: 22, height: 20)
                        
                        Text("SETTINGS")
                            .font(Font.custom("Futura", size: 12.0).weight(.heavy))
                    }
                }
                    
                ZStack() {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    Image(systemName: "house")
                        .fontWeight(.heavy)
                        .frame(width: 22, height: 20)
                }
                

                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    
                    Image(systemName: "message")
                        .fontWeight(.heavy)
                        .frame(width: 24, height: 22)
                }
                    
            }
            .padding(.all, 8)
            

            // Current page index
//            Circle()
//                .foregroundColor(.black)
//                .frame(width: circleDiameter, height: circleDiameter)
//                .offset(x: currentPosition)
//                .animation(.linear(duration: 0.3))
        }
        .frame(height: 55)
        .padding()
        
        Spacer()
    }
}

struct RSPageControllerPreview: View {

    var pages: Int = 3
    @State var selectedPage: Int = 1

    var body: some View {
        VStack(spacing: 20) {
//            HStack {
//                Button(action: {
//                    selectedPage = selectedPage - 1
//                }, label: {
//                    Image(systemName: "arrow.left.square.fill")
//                        .resizable()
//                        .frame(width: 40, height: 40)
//                        .foregroundColor(.black)
//                })
//
//                Button(action: {
//                    selectedPage = selectedPage + 1
//                }, label: {
//                    Image(systemName: "arrow.right.square.fill")
//                        .resizable()
//                        .frame(width: 40, height: 40)
//                        .foregroundColor(.black)
//                })
//            }

            RSPageController(selectedPage: $selectedPage, pages: pages, circleDiameter: 15.0, circleMargin: 10.0)
        }
    }
}

struct RSPageControl_Previews: PreviewProvider {
    static var previews: some View {
        RSPageControllerPreview()
    }
}
