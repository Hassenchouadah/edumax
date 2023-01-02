//
//  CourseRow.swift
//  edumax
//
//  Created by user231981 on 12/12/22.
//

import SwiftUI

struct CourseRow: View {
    var firstCourse:CourseModel
    var seoncdCourse:CourseModel?

    var body: some View {
        HStack(spacing: 20){
            VStack(spacing: 12){
                
                Image(firstCourse.title)
                    .resizable()
                    .frame(width: 80, height: 80)
                
                Text(firstCourse.title)
                    .font(.title)
                    .padding(.top,10)
                
                Text(firstCourse.title)
                    .foregroundColor(Color("Color"))
                
                Text("1 Year")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
            // shadows...
            
            if(seoncdCourse != nil){
                VStack(spacing: 12){
                    
                    Image(seoncdCourse!.title)
                        .resizable()
                        .frame(width: 80, height: 80)
                    
                    Text(seoncdCourse!.title)
                        .font(.title)
                        .padding(.top,10)
                    
                    Text("UI/UX Designer")
                        .foregroundColor(Color("Color"))
                    
                    Text("3 Year")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical)
                // half screen - spacing - two side paddings = 60
                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                .background(Color("Color1"))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
            }

            // shadows...
            
        }.padding(.top,20)    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        CourseRow(
            firstCourse: CourseModel(_id: "", title: "", description: "", price: "", image: "", mentor: MentorModel(_id: "", firstName: "", lastName: "", email: "", avatar: "")),
            seoncdCourse: CourseModel(_id: "", title: "", description: "", price: "", image: "", mentor: MentorModel(_id: "", firstName: "", lastName: "", email: "", avatar: "")))
    }
}
