//
//  ViewController.swift
//  PartsAssembly
//
//  Created by SUNG on 1/25/24.
//

import UIKit

/*
 push / pop
 -> nagation stack -> UINavigationController (UINavgationBar)
 
 present / dismiss
 -> 조건없음
 */

class ViewController: UIViewController  {
//    struct Friend {
//        var name: [String] = ["송선우", "권석훈", "풍재근", "설태연", "풍희태", "조서은", "유유빈", "홍은재", "복원", "안남혁"]
//        var status: [String] = ["내 인생을 바꾸는 사람은 자신입니다. 아무도 대신해줄 수 없어요."
//                                , "지금 아니면 언제 하실 건가요?"
//                                , "자기자신을 믿으세요"
//                                , "과거에 연연하지 마세요"
//                                , ""
//                                , "완벽한 인생을 원하지 않고 행복한 삶을 원합니다."
//                                , "땀 없인 달콤함도 없다."
//                                , ""
//                                , "부모님의 존재를 당연시하지 마세요."
//                                , "완벽한 인생을 원하지 않고 행복한 삶을 원합니다."]
//    }
    //MARK: properties
//    let myProfile: Friend = Friend(name: "나", status: "인생은 가늘고 길게...", profileImageName: "10")
    
    let friendList: [Friend] = [
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
    
    // MARK: OUTLET
    @IBOutlet weak var friendTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendTableView.dataSource = self
        friendTableView.delegate = self
    }
    
    //let friend = Friend()

    // MARK: function
    func saveStringToUserDefaults(key: String, value: String) {
        // 값 저장
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    func fetchStringFromUserDefaults(key: String) -> String? {
        // 값 가져오기
        return UserDefaults.standard.string(forKey: key)
    }
    
    func checkSavedMyProfileData() {
        //        let savedName = fetchStringFromUserDefaults(key: "name")
        //        let savedStatus = fetchStringFromUserDefaults(key: "status")
        //        let savedProfileImageName = fetchStringFromUserDefaults(key: "profileImageName")
        //        if savedName != myProfile.name
        //            || savedStatus != myProfile.status
        //            || savedProfileImageName != savedProfileImageName {
        //            saveStringToUserDefaults(key: "name", value: myProfile.name)
        //            saveStringToUserDefaults(key: "status", value: myProfile.status)
        //            saveStringToUserDefaults(key: "profileImageName", value: myProfile.profileImageName)
        //        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "내 프로필"
        } else {
            return "친구 목록"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return friendList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
        cell.profileImageView.image = UIImage(named: "\(indexPath.row + 1)")
        cell.profileImageView.layer.cornerRadius = 15
        
        if indexPath.section == 0 {
            let savedName = fetchStringFromUserDefaults(key: "name")
            let savedStatus = fetchStringFromUserDefaults(key: "status")
            if let savedProfileImage = fetchStringFromUserDefaults(key: "profileImageName") {
                cell.profileImageView.image = UIImage(named: savedProfileImage)
            } else {
                cell.profileImageView.image = UIImage(systemName: "person.circel.fill")
            }
            
            cell.nameLabel.text = savedName ?? "(알 수 없음)"
            cell.statusLabel.text = savedStatus ?? "(알 수 없음)"
        } else {
            let friend = friendList[indexPath.row]
            cell.profileImageView.image = UIImage(named: friend.profileImageName)
            cell.nameLabel.text = friend.name
            cell.statusLabel.text = friend.status
        }
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 32
        } else {
            return 18
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) selected.")
        
        // 1. 어떤 화면을 보여줄지 선언 (캐스팅)
        // 2. 캐스팅한게 옵셔널이 아니도록 언래핑
        // let detailVC = DetailViewController() // <- 코드베이스
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else { return }
        
        // 3. present, push 해줄 지 결정
        // 4. present 보여주는 방식에 대해서 속성을 설정
        //detailVC.modalPresentationStyle = .fullScreen
        
        // 5. 다음화면으로 넘겨주고 싶은 데이터를 대입
        if indexPath.section == 0 {
            if let savedName = fetchStringFromUserDefaults(key: "name"),
               let savedStatus = fetchStringFromUserDefaults(key: "status"),
               let savedProfileImage = fetchStringFromUserDefaults(key: "profileImageName") {
                let myProfile: Friend? = Friend(name: savedName, status: savedStatus, profileImageName: savedProfileImage)
                print("savedName: \(savedName)")
                print("savedStatus: \(savedStatus)")
                print("savedProfileImage: \(savedProfileImage)")
                detailVC.friend = myProfile
            }
            
        } else {
            let selectedData = friendList[indexPath.row]
            detailVC.friend = selectedData
        }
        detailVC.isCloseButtonHidden = true
        
        // 6. 화면 전환
        //self.present(detailVC, animated: true)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


class FriendTableViewCell: UITableViewCell {
    // MARK: OUTLET
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
}
