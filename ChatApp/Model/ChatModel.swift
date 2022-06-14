//
//  ChatModel.swift
//  ChatApp
//
//  Created by 이은지 on 2022/06/13.
//

import Foundation

struct Chat: Identifiable {
    var id: UUID { person.id }
    let person: Person
    var message: [Message]
    var hasUnreadMessage = false
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let imgString: String
}

struct Message: Identifiable {
    
    enum MessageType {
        case Sent, Received
    }
    
    let id = UUID()
    let date: Date
    let text: String
    let type: MessageType
    
    init(_ text: String, type: MessageType, date: Date) {
        self.date = date
        self.type = type
        self.text = text
    }
    
    init(_ text: String, type: MessageType) {
        self.init(text, type: type, date: Date())
    }
}

extension Chat {
    static let sampleChat = [
        Chat(person: Person(name: "이승재", imgString: "img1"), message: [
            Message("우리 후쿠오카 여행가서 어디어디 갈까?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 5)),
            Message("맛집도 돌아다니고, 쇼핑도 하고, 기차타고 근교로 온천여행도 가자! 😙", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 5)),
            Message("온천 좋다. 혹시 가보고싶었던 온천 있어?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 4)),
            Message("아니 그런 곳은 없는데 내가 한 번 알아볼게!", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 4)),
            Message("응! 가고싶은 곳 찾아보고 말해줘", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 4)),
            Message("알았어!👌🏻", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 4)),
            Message("어디쯤이야?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("지하철 타고 가고 있어. 20분 뒤에 도착할 것 같아.", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("알았어~ 나도 그때 쯤 도착할 것 같아. 조심히와~", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("응 이따봐~", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3))
        ], hasUnreadMessage: false),
        
        Chat(person: Person(name: "김다은", imgString: "img4"), message: [
            Message("너 나의 해방일지 봤어? 🫣", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("당연하지 진짜 너무 재밌어", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("몇화까지 봄? 손석구 진짜 멋있지 않냐 ㅠㅠ", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("그니까ㅠㅠ 지금 10화까지 봤고 나머지 이번 주말에 다 볼거야", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 1))
        ], hasUnreadMessage: true),
        
        Chat(person: Person(name: "박재형", imgString: "img3"), message: [
            Message("프로그래밍 공부 할만해?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("응 어려운 부분도 많은데 하나씩 해결해나가는 재미도 있고 알아가는 재미도 있는 것 같아.", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("다행이다. 내 도움 필요하면 말해! 언제든지 도와줄게", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("고마워. 다음에 같이 재밌는 프로젝트 하나 해보자. 👍🏻", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2))
        ], hasUnreadMessage: false),
        
        Chat(person: Person(name: "최이재", imgString: "img5"), message: [
            Message("이재야 공연 언제야?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("이번주 토요일 6시! 올 수 있어?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("응 공연보러갈게! 오랜만에 공연보러가는거라 기대된다 😝", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
            Message("그러게!!! 꼭 와서 맥주도 마시고 맛있는 음식도 먹고 재밌게 놀아! 👏🏻 ", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 1))
        ], hasUnreadMessage: true),
        
        Chat(person: Person(name: "이승화", imgString: "img6"), message: [
            Message("승화야 이번 주말에 같이 점심 먹을래?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("좋아 🤗 먹고싶은거 있어?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("음 연남동쪽에 맛집 한 번 찾아볼까?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("연남동? 좋지~~ 나도 한 번 찾아볼게!", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("양식 괜찮아? 한식 먹을까?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
            Message("난 둘 다 좋은데 너가 먹고싶은걸로 먹자!", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 1)),
            Message("음 오랜만에 파스타 먹고싶다. 양식 고고 😇", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1))
        ], hasUnreadMessage: false),
        
        Chat(person: Person(name: "김현수", imgString: "img2"), message: [
            Message("너 다음주 지연이 결혼식 가?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("응 가야지~ 너도 오지?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("응 나도가 ㅎㅎ 그 날 애들이랑 같이 얼굴보자!", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2))
        ], hasUnreadMessage: false)
    ]
}
