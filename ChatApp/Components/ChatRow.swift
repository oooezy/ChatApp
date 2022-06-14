//
//  ChatRow.swift
//  ChatApp
//
//  Created by 이은지 on 2022/06/13.
//

import SwiftUI

struct ChatRow: View {
    let chat: Chat
    
    var body: some View {
        HStack(spacing: 20) {
            Image(chat.person.imgString)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
            
            ZStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(chat.person.name)
                            .bold()
                        Spacer()
                        
                        Text(chat.message.last?.date.descriptiveString() ?? "")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                    
                    HStack {
                        Text(chat.message.last?.text ?? "")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .lineLimit(2)
                            .frame(height: 50, alignment: .top)
                            .padding(.trailing, 40)
                    }
                }
                
                Circle()
                    .foregroundColor(chat.hasUnreadMessage ? .blue : .clear)
                    .frame(width: 10, height: 10)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(height: 80)
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chat: Chat.sampleChat[1])
    }
}
