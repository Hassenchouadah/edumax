//
//  CourseCard.swift
//  edumax
//
//  Created by user231981 on 11/29/22.
//

import SwiftUI

struct CourseCard: View {
    @State var checked = false;
    
    
    var course: CourseModel
    var wishlistStorage = WishlistStorage()
    
    let name:String = ""
    
    
    func initialize() -> Void {
        var courseFromWishlist = wishlistStorage.getCourseById(id: course._id);
        if(courseFromWishlist == nil){
            checked=false;
        }else{
            checked=true;
        }
        
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: "http://localhost:5001\(course.image)")!,
                               placeholder: { Text("Loading ...") },
                           image: { Image(uiImage: $0).resizable() })
                .cornerRadius(20)
                .frame(width: 180)
                .scaledToFit()
                        

                
                
                VStack(alignment: .leading) {
                    Text(course.title)
                        .bold()
                    
                    Text("\(course.price)$")
                        .font(.caption)
                }
                .padding()
                .frame(width: 180, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
            }
            .frame(width: 180, height: 250)
            .shadow(radius: 3)
            
            Button {
                if(wishlistStorage.getCourseById(id:course._id) == nil){
                    wishlistStorage.save(course: course );
                    
                }else{
                    wishlistStorage.deleteById(id:course._id);
                    
                }
                checked.toggle();
                
            } label: {
                if(checked==false){
                    Image(systemName: "star")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(50)
                        .padding()
                }else{
                    Image(systemName: "star.fill")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(50)
                        .padding()
                }
                
            }
        }.onAppear(perform: initialize)
    }
}

struct CourseCard_Previews: PreviewProvider {
    static var previews: some View {
        CourseCard(course: CourseModel(_id: "", title: "title", description: "", price: "80", image: "http://localhost:5001/uploads/courses/1.png",mentor: UserModel(_id: "", email: "", password: "", phone: "", avatar: "", verified: 0, token: "", firstName: "", lastName: "", role: "")))
    }
}
