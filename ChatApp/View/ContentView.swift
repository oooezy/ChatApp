//
//  ContentView.swift
//  ChatApp
//
//  Created by 이은지 on 2022/06/13.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ChatsViewModel()
    
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.getSortedFilteredChats(query: query)) { chat in
                    
                    ZStack {
                        ChatRow(chat: chat)
                        
                        NavigationLink(destination: {
                            ChatView(chat: chat)
                                .environmentObject(viewModel)
                            }
                        ) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0)
                        .opacity(0)
                    }
                    .swipeActions(edge: .leading) {
                        Button(action: {
                            viewModel.markAsUnread(!chat.hasUnreadMessage, chat: chat)
                        }) {
                            if chat.hasUnreadMessage {
                                Label("Read", systemImage: "envelope.open")
                                    .labelStyle(IconOnlyLabelStyle())

                            } else {
                                Label("Unread", systemImage: "envelope.badge")
                                    .labelStyle(IconOnlyLabelStyle())
                            }
                        }
                        .tint(.blue)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(action: {
                            viewModel.removeMessage(chat: chat)
                        }) {
                            Label("Delete", systemImage: "trash")
                                .labelStyle(IconOnlyLabelStyle())
                        }
                        .tint(.red)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Chats", displayMode: .large)
            .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
