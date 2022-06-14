//
//  ChatView.swift
//  ChatApp
//
//  Created by 이은지 on 2022/06/13.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var viewModel: ChatsViewModel
    
    let chat: Chat
    
    @State private var text = ""
    @State private var messageIDToScroll: UUID?
    @FocusState private var isFocused
    
    @Namespace var bottomID
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { reader in
                ScrollView {
                    ScrollViewReader { scrollReader in
                        getMessagesView(viewWidth: reader.size.width)
                            .padding(.horizontal)
                            .onChange(of: messageIDToScroll) { _ in
                                if let messageID = messageIDToScroll {
                                   scrollTo(messageID: messageID, shouldAnimate: true, scrollReader: scrollReader)
                                }
                            }
                            .onAppear {
                                if let messageID = chat.message.last?.id {
                                    scrollTo(messageID: messageID, anchor: .bottom, shouldAnimate: false, scrollReader: scrollReader)
                                }
                            }
                            .onChange(of: isFocused) { _ in
                                if isFocused {
                                    withAnimation(.easeIn(duration: 0.5)) { scrollReader.scrollTo(bottomID)
                                    }
                                }
                            }
                        HStack {}.id(bottomID)
                    }
                    .padding()
                }
            }
            .padding(.bottom, 5)
            toolbarView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: navBarLeadingBtn, trailing: navBarTrailingBtn)
        .onAppear {
            viewModel.markAsUnread(false, chat: chat)
            isFocused = false
        }
        .onAppear(perform : UIApplication.shared.hideKeyboard)
    }
    
    var navBarLeadingBtn: some View {
        Button(action: {}) {
            HStack {
                Image(chat.person.imgString)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                Text(chat.person.name).bold()
            }
            .foregroundColor(.black)
        }
    }
    
    var navBarTrailingBtn: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
    
    func scrollTo(messageID: UUID, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn : nil) {
                scrollReader.scrollTo(messageID, anchor: anchor)
            }
        }
    }
    
    func toolbarView() -> some View {
        VStack {
            let height: CGFloat = 42
            HStack {
                TextField("Message...", text: $text)
                    .padding(.horizontal, 5)
                    .padding(.leading, 10)
                    .frame(height: height)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .focused($isFocused)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane")
                        .frame(width: height, height: height)
                        .foregroundColor(text.isEmpty ? .gray : .indigo)
                }
                .disabled(text.isEmpty)
            }
            .frame(height: height)
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.thickMaterial)
        .onTapGesture {
            isFocused = true
        }
    }
    
    func sendMessage() {
        if let message = viewModel.sendMessage(text, in: chat) {
            text = ""
            messageIDToScroll = message.id
        }
    }
    
    let columns = [GridItem(.flexible(minimum: 10))]
    
    func getMessagesView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 20) {
            let sectionMessages = viewModel.getSectionMessages(for: chat)
            ForEach(sectionMessages.indices, id: \.self) { sectionIndex in
                let messages = sectionMessages[sectionIndex]
                Section(header: sectionHeader(firstMessage: messages.first!)) {
                    ForEach(messages) { message in
                        let isReceived = message.type == .Received
                        HStack {
                            ZStack {
                                Text(message.text)
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                                    .background(isReceived ? Color.indigo.opacity(0.1) : Color.indigo.opacity(0.5))
                                    .cornerRadius(20)
                                    .foregroundColor(isReceived ? .black : .white)
                            }
                            .frame(width: viewWidth * 0.7, alignment: isReceived ? .leading : .trailing)
                        }
                        .frame(maxWidth: .infinity, alignment: isReceived ? .leading : .trailing)
                        .id(message.id)
                    }
                }
            }

        }
    }
    
    func sectionHeader(firstMessage message: Message) -> some View {
        VStack {
            Text(message.date.descriptiveString())
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .regular))
                .padding(.vertical)
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView(chat: Chat.sampleChat[1])
                .environmentObject(ChatsViewModel())
        }
    }
}

