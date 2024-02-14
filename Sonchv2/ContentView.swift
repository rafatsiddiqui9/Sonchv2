//
//  ContentView.swift
//  Sonchv2
//
//  Created by Rafat on 13/02/24.
//

import SwiftUI
@_exported import Inject

struct ContentView: View {
    @State var chatMessages: [ChatMessage] = ChatMessage.sampleMessages()
    @State var messageText: String = ""
    let openAIService = OpenAIService()

    var body: some View {
        VStack {
            ScrollView {
            LazyVStack {
                ForEach(chatMessages, id: \.id) { message in messageView(message: message)
                }
            }   
            }
            HStack {
                TextField("Enter a message", text: $messageText){

                }
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(12)
                Button {
                    sendMessage()
                } label: {
                    Text("Send")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                }
            }
        }
        .padding()
        .onAppear{
            openAIService.sendMessage(message: "Generate a tagline for an ice cream shop.")
        }
        .enableInjection()
    }
    func messageView(message: ChatMessage) -> some View {
        HStack {
            if message.sender == .me {
                Spacer()
            }
            Text(message.content)
                .foregroundColor(message.sender == .me ? Color.white : Color.black)
                .padding()
                .background(message.sender == .me ? Color.blue : Color.green.opacity(0.1))
                .cornerRadius(16)
            if message.sender == .gpt {
                Spacer()
            }
        }
    }
        func sendMessage() {
            messageText = ""
        print(messageText)
    }
}

//#Preview {
//    ContentView()
//}

struct ContentView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ChatMessage {
    let id: String
    let content: String
    let dateCreated: Date
    let sender: MessageSender
}

enum MessageSender {
    case me
    case gpt
}

extension ChatMessage {
    static let sampleMessages = { [
        ChatMessage(id: UUID().uuidString, content: "Hello, world!", dateCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Hello, world!", dateCreated: Date(), sender: .gpt),
        ChatMessage(id: UUID().uuidString, content: "Hello, world!", dateCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Hello, world!", dateCreated: Date(), sender: .gpt)
]    }
}
