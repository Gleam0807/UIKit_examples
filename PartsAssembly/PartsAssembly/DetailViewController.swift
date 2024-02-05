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
    enum ViewType {
        case my(profile: Friend)
        case friend(index: Int)
    }
    
    var viewType: ViewType = .friend(index: 0)
    
    //MARK: properties
    var isCloseButtonHidden: Bool = false

    //MARK: OUTLET
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    
    override func viewDidLoad() {
        makeNavigationButton()
        self.navigationController?.navigationBar.tintColor = .black
        
        if isCloseButtonHidden {
            closeButton.isHidden = true
        }
        
        switch viewType {
        case .my(let profile):
            profileImageView.image = UIImage(named: profile.profileImageName)
            nameTextField.text = profile.name
            statusTextField.text = profile.status
        case .friend(let index):
            let friend = Friend.friendList[index];
            profileImageView.image = UIImage(named: friend.profileImageName)
            nameTextField.text = friend.name
            statusTextField.text = friend.status
        }
    }
    
    func makeNavigationButton() {
        let rightNavigationBarButton = UIBarButtonItem(title: "저장", style: .plain ,target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItem = rightNavigationBarButton
    }

    @objc func saveAction() {
        switch viewType {
        case .my(_):
            saveStringToUserDefaults(key: "name", value: nameTextField.text ?? "")
            saveStringToUserDefaults(key: "status", value: statusTextField.text ?? "")
        case .friend(let index):
            let selectedFriend = Friend.friendList[index]
            let updatedFriend = Friend(
                name: nameTextField.text ?? "",
                status: statusTextField.text ?? "",
                profileImageName: selectedFriend.profileImageName)
            Friend.friendList[index] = updatedFriend
        }
        
        func saveStringToUserDefaults(key: String, value: String) {
            // 값 저장
            UserDefaults.standard.setValue(value, forKey: key)
        }
    }
    
    @IBAction func closeButtonClieked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
