//
//  Courses.swift
//  edumax
//
//  Created by user231981 on 11/29/22.
//

import SwiftUI

struct CoursesView: View {
    
    @State var courses = [CourseModel]()
    
    @State var wishlist = [CourseModel]()
    
    
    func loadCourses() {
        guard let url = URL(string: "http://3.9.193.138:5001/api/courses/") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([CourseModel].self, from: data) {
                    DispatchQueue.main.async {
                        self.courses = response
                    }
                    return
                }
            }
        }.resume()
    }
    
   
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(courses, id: \._id) { course in
                
                        NavigationLink(destination: CourseDetails(course:course) ) {
                            CourseCard(course: course)
                        }
                        
                            
                    }
                }.onAppear(perform: loadCourses)
                .padding()
            }
            .navigationTitle(Text("Courses"))
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
