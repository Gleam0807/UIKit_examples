//
//  Friend.swift
//  PartsAssembly
//
//  Created by SUNG on 1/27/24.
//

import Foundation

// MARK: MODEL
struct Friend {
    var name: String
    var status: String
    let profileImageName: String
    
    static var friendList: [Friend] = [
        Friend(name: "송선우", status: "내 인생을 바꾸는 사람은 자신입니다. 아무도 대신해줄 수 없어요.", profileImageName: "1"),
        Friend(name: "권석훈", status: "지금 아니면 언제 하실 건가요?", profileImageName: "2"),
        Friend(name: "풍재근", status: "과거에 연연하지 마세요", profileImageName: "3"),
        Friend(name: "설태연", status: "", profileImageName: "4"),
        Friend(name: "풍희태", status: "완벽한 인생을 원하지 않고 행복한 삶을 원합니다.", profileImageName: "5"),
        Friend(name: "조서은", status: "땀 없인 달콤함도 없다.", profileImageName: "6"),
        Friend(name: "유유빈", status: "", profileImageName: "7"),
        Friend(name: "홍은재", status: "", profileImageName: "8"),
        Friend(name: "복원", status: "부모님의 존재를 당연시하지 마세요.", profileImageName: "9"),
        Friend(name: "안남혁", status: "완벽한 인생을 원하지 않고 행복한 삶을 원합니다.", profileImageName: "10")
    ]
}

