//
//  ViewController.swift
//  PartsAssembly
//
//  Created by SUNG on 1/25/24.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    // MARK: MODEL
    struct Friend {
        var name: [String] = ["송선우", "권석훈", "풍재근", "설태연", "풍희태", "조서은", "유유빈", "홍은재", "복원", "안남혁"]
        var status: [String] = ["내 인생을 바꾸는 사람은 자신입니다. 아무도 대신해줄 수 없어요."
                                , "지금 아니면 언제 하실 건가요?"
                                , "자기자신을 믿으세요"
                                , "과거에 연연하지 마세요"
                                , ""
                                , "완벽한 인생을 원하지 않고 행복한 삶을 원합니다."
                                , "땀 없인 달콤함도 없다."
                                , ""
                                , "부모님의 존재를 당연시하지 마세요."
                                , "완벽한 인생을 원하지 않고 행복한 삶을 원합니다."]
    }
    
    // MARK: OUTLET
    @IBOutlet weak var friendTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendTableView.dataSource = self
        friendTableView.delegate = self
        
    }
    
    let friend = Friend()

    // MARK: function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend.name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as? FriendTableViewCell else { return UITableViewCell()}

        
        cell.profileImageView.image = UIImage(named: "image/\(indexPath.row + 1).png")
        cell.profileImageView.layer.cornerRadius = 15
        
        cell.nameLabel.text = friend.name[indexPath.row]
        cell.statusLabel.text = friend.status[indexPath.row]
        
        return cell
    }
    
}


class FriendTableViewCell: UITableViewCell {
    // MARK: OUTLET
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
}
