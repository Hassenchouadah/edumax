//
//  ChatView.swift
//  edumax
//
//  Created by user231981 on 12/13/22.
//

import SwiftUI

struct ChatView: View {
    var friend:UserModel;
    var body: some View {
            storyBoardView(friend: friend).edgesIgnoringSafeArea(.all)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(friend: UserModel(_id: "", email: "", password: "", phone: "", avatar: "", verified: 0, token: "", firstName: "", lastName: "", role: ""))
    }
}

struct storyBoardView:UIViewControllerRepresentable {
    var friend:UserModel;

    func makeUIViewController(context content:Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = (storyboard.instantiateViewController(withIdentifier: "Chat") as! ChatController)
        controller.friend = friend
        return controller;
    }
    
    func updateUIViewController(_ uiViewController: UIViewController,context:Context) {
        
    }
}



