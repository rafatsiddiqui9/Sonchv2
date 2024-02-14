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

    var body: some View {
        VStack {
            ScrollView {
            LazyVStack {
                ForEach(chatMessages, id: \.id) { message in messageView(message: message)
                }
            }   
            }
            HStack {
                TextField("Enter a message", text: $messageText)
                .padding(12)
                .background(.gray.opacity(0.1))
                .cornerRadius(12)
                Button {
                    chatMessages.append(ChatMessage(id: UUID().uuidString, content: messageText, dateCreated: Date(), sender: .me))
                    messageText = ""
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
