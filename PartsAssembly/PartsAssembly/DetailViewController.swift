//
//  DetailViewController.swift
//  PartsAssembly
//
//  Created by SUNG on 1/27/24.
//

/*
 view life cycle
  - loadView : 메모리상 뷰 로드
  - viewDidLoad : 데이터 초기화 작업
  - viewWillappear : 사용자에게 화면이 보여지기 직전
  - viewDidappear : 사용자에게 화면이 보여진 직후
  - viewWillDisappear : 사용자에게 화면이 사라지기 직전
  - viewDidDisappear : 사용자에게 화면이 사라진 직후
 */

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: properties
    var friend: Friend?

    //MARK: OUTLET
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        print("friend: \(friend)")
        
        if let friend = friend {
            profileImageView.image = UIImage(named: friend.profileImageName)
            nameLabel.text = friend.name
            statusLabel.text = friend.status
        }
        else {
            nameLabel.text = "(알 수 없음)"
            statusLabel.text = "(알 수 없음)"
        }
    }
    
    
    @IBAction func closeButtonClieked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
