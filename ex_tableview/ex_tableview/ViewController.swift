//
//  ViewController.swift
//  ex_tableview
//
//  Created by SUNG on 1/24/24.
//

import UIKit

/* UITableView
 - Class
 - UIKit 안에 포함
 - 꼭 준수해야하는 프로토콜  2개 -> dataSorurce, delegate
 - UITableViewDataSource : Data에 관련된 함수들. ex. 몇개의 데이터를 보여줄 것인지.
 - UITableViewDelegate : ex. 액션이나 설정값에 대한 것들 
 
 선언하는 방법 3가지
 - storyboard에서 Table View Controller 추가(비추)
 - storyboard에서 View Controller안에 Table View를 추가하여 선언
 - 코드로 선언해서 추가 <- *****중요
 
 같은 모양의 row가 반복적으로 보여지는 형태
 -> row가 어떻게 생겼는지
 
 셀 만드는 방법
 1. prototype cell 추가
 2. prototype cell UI 구성
 3. class를 만든다
 4. 만든 클래스와 storyboard에 cell을 연결한다
 5. cell의 reuse identifier르 지정
 6. 아웃렛 연결
 */

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var sampleData: [String] = []
    var ageData: [Int] = []
    var tupleData: [(name: String, age: Int)] = []
    
    @IBOutlet weak var someTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleData = splitToArray(str: "정건, 고웅, 김훈, 임훈, 이철, 배웅, 박웅, 홍철, 신철, 예훈, 윤철, 이훈, 노호, 제갈철, 임건")
        ageData = [11, 22, 33, 44, 55, 66, 77, 88, 99, 111, 122, 133, 144, 155, 166]
        for i in 0..<sampleData.count {
            tupleData.append((sampleData[i], ageData[i]))
        }
       
        someTableView.dataSource = self
        someTableView.delegate = self
    }
    
    func splitToArray(str: String) -> [String]{
        return str.components(separatedBy: ", ")
    }

    // 몇개의 데이터를 뿌려줄것인지 줄 갯수를 지정해주는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    // 어떻게 생긴 cell을 보여줄 것인지 지정해주는 함수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // identifier 오타나면 인식을 못함
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as? SomeTableViewCell else { return UITableViewCell()}
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as? NewTableViewCell else { return UITableViewCell()}
//        let name = sampleData[indexPath.row]
//        cell.newTitleLabel.text = name
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "doubleCell", for: indexPath) as? DoubleTableViewCell else { return UITableViewCell()}
//        let name = sampleData[indexPath.row]
//        let age = ageData[indexPath.row]
//        
//        cell.doubleTitelLabel.text = name
//        cell.doubleSubTitleLabel.text = "\(age)"
//        let name = tupleData[indexPath.row].name
//        let age = tupleData[indexPath.row].age
        let person = tupleData[indexPath.row]

        cell.doubleTitelLabel.text = person.name
        cell.doubleSubTitleLabel.text = "\(person.age)"
        
        return cell
    }
    
    //셀이 눌렸다는 신호를 테이블뷰한테 알려주는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) selected.")
        // ex.다음 화면으로 넘어가는 코드 등
    }
    
    //row의 높이를 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "섹션 헤더"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "섹션 푸터"
    }
}

class SomeTableViewCell: UITableViewCell {
    static let identifier = "firstCell" // 타입 프로퍼티
    @IBOutlet weak var titleLabel: UILabel!
}

class NewTableViewCell: UITableViewCell {
    @IBOutlet weak var newTitleLabel: UILabel!
}

class DoubleTableViewCell: UITableViewCell {
    @IBOutlet weak var doubleTitelLabel: UILabel!
    @IBOutlet weak var doubleSubTitleLabel: UILabel!
}
