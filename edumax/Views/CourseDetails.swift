//
//  DetailView.swift
//  edumax
//
//  Created by user231981 on 11/29/22.
//

import SwiftUI

import SwiftUI

struct CourseDetails: View {
    @State var course:CourseModel;
    var courseService = CourseService();
    

    
    func fetchCourse() -> Void {
        courseService.getCourseById(id: course._id,onSuccess: {[self] (response) in
            DispatchQueue.main.async {
                self.course = response
            }
        }, onError: {(error) in
            DispatchQueue.main.async {
                print(error.localizedDescription)
            }
        })
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Bg")
                ScrollView  {
                    
                    AsyncImage(url: URL(string: "http://localhost:5001\(course.image)")!,
                                   placeholder: { Text("Loading ...") },
                               image: { Image(uiImage: $0).resizable() })
                    .frame(width:400,height: 380)
                    .scaledToFit()
                            
                            
                            .edgesIgnoringSafeArea(.top)
                    
                    DescriptionView(course:course)
                    
                }
                .edgesIgnoringSafeArea(.top)
                
                HStack {
                    Text(course.price)
                        .font(.title)
                        .foregroundColor(.white)
                    Spacer()
                    
                    NavigationLink(destination: ARView() ) {
                        Text("Enroll")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hex: 0x7993afff))
                            .padding()
                            .padding(.horizontal, 8)
                            .background(Color.white)
                            .cornerRadius(10.0)
                    }
                    
                    
                }
                .padding()
                .padding(.horizontal)
                .background( Color(hex: 0x7993afff) )
                .cornerRadius(60.0, corners: .topLeft)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        
        
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetails(course:CourseModel(_id: "", title: "", description: "", price: "", image: "",mentor: MentorModel(_id: "", firstName: "", lastName: "", email: "", avatar: "")))
    }
}


struct ColorDotView: View {
    let color: Color
    var body: some View {
        color
            .frame(width: 24, height: 24)
            .clipShape(Circle())
    }
}

struct DescriptionView: View {
    @State var refresh: Bool = false

    var course:CourseModel;
    
    
    var body: some View {
        VStack (alignment: .leading) {
            //                Title
            
            HStack {
                Text(course.title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button {
                   print("Added to whishlist")
                }label: {
                    Image(systemName: "star")
                }
                
            }
            //                Rating
            HStack (spacing: 4) {
                ForEach(0 ..< 5) { item in
                    Image("star").resizable()
                        .frame(width:20,height: 20)
                        .scaledToFit()
                }
                Text("(4.9)")
                    .opacity(0.5)
                    .padding(.leading, 8)
                Spacer()
            }
            
            Text("Description")
                .fontWeight(.medium)
                .padding(.vertical, 8)
            Text(course.description)
                .lineSpacing(8.0)
                .opacity(0.6)
            
            //                Info
            HStack (alignment: .top) {
                VStack (alignment: .leading) {
                    Text("Mentor")
                    
                    HStack(alignment: .top){
                        if(course.mentor != nil){
                            
                            AsyncImage(url: URL(string: "http://localhost:5001\(course.mentor!.avatar)")!,
                                           placeholder: { Text("Loading ...") },
                                       image: { Image(uiImage: $0).resizable() })
                            .frame(width:40,height: 40)
                            .scaledToFit()
                            Text(course.mentor!.firstName)
                                .opacity(0.6)
                            Text(course.mentor!.lastName)
                                .opacity(0.6)
                        }
                        
                    }
                    
                    
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                

            }
            .padding(.vertical)
            
            //                Colors and Counter

        }
        .padding()
        .padding(.top)
        .background(Color("Bg"))
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .offset(x: 0, y: -30.0)
    }
}


struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
                .padding(.all, 12)
                .background(Color.white)
                .cornerRadius(8.0)
        }
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
