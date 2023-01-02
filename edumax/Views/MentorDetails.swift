//
//  MentorDetails.swift
//  edumax
//
//  Created by user231981 on 12/12/22.
//



import SwiftUI

struct MentorDetails: View {
    @State var index = 0;
    let courseService: CourseService = CourseService();
    @State var courses:[CourseModel] = []
    
    func fetchCourses() -> Void {
        courseService.getCoursesByMentor(id: mentor._id,onSuccess: {[self] (response) in
            DispatchQueue.main.async {
                self.courses = response
            }
        }, onError: {(error) in
            DispatchQueue.main.async {
                print(error.localizedDescription)
            }
        })

    }

    
    var mentor:UserModel;
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]

    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    
                    
                    
                    HStack{
                        
                        VStack(spacing: 0){
                            
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 80, height: 3)
                                .zIndex(1)
                            
                            
                            // going to apply shadows to look like neuromorphic feel...
                            
                            AsyncImage(url: URL(string: "http://localhost:5001\(mentor.avatar)")!,
                                       placeholder: { Text("Loading ...") },
                                       image: { Image(uiImage: $0).resizable() })
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                            .padding(.top, 6)
                            .padding(.bottom, 4)
                            .padding(.horizontal, 8)
                            .background(Color("Color1"))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                        }
                        
                        VStack(alignment: .leading, spacing: 12){
                            
                            Text(mentor.firstName + " " + mentor.lastName)
                                .font(.title)
                                .foregroundColor(Color.black.opacity(0.8))
                            
                            Text("iOS Developer")
                                .foregroundColor(Color.black.opacity(0.7))
                            
                            Text(mentor.email)
                                .foregroundColor(Color.black.opacity(0.7))
                        }
                        .padding(.leading, 20)
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Tab Items...
                    
                    HStack{
                        
                        Button(action: {
                            
                        }) {
                            
                            Text("Courses")
                                .foregroundColor(Color.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        
                        Spacer(minLength: 0)
                        
                        NavigationLink(destination: ChatView(friend: mentor)) {
                            Text("Envoyer un message")
                                .foregroundColor(.gray)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(Color.clear)
                                .cornerRadius(10)
                        }

                        
                        Spacer(minLength: 0)
                        
                    }
                    .padding(.horizontal,8)
                    .padding(.vertical,5)
                    .background(Color("Color1"))
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                    .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                    .padding(.horizontal)
                    .padding(.top,25)
                    
                    // Cards...
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(courses, id: \._id) { course in
                            NavigationLink(destination: CourseDetails(course:course) ) {
                                
                                CourseCard(course: course)
                                // half screen - spacing - two side paddings = 60
                                
                                    .background(Color("Color1"))
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                                    .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                            }
                            
                        }
                    }.padding(.horizontal,15)
                    
                    
                    
                    
                    
                    Spacer(minLength: 0)
                }
                .background(Color("Color1").edgesIgnoringSafeArea(.all))
            }
            .navigationTitle(Text("Profile"))

        }.onAppear(perform:fetchCourses)
        
        
    }
    
    struct MentorDetails_Previews: PreviewProvider {
        static var previews: some View {
            MentorDetails(mentor: UserModel(_id: "", email: "", password: "", phone: "", avatar: "", verified: 1, token: "", firstName: "", lastName: "", role: ""))
        }
    }
}






