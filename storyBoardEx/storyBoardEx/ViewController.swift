//
//  ViewController.swift
//  storyBoardEx
//
//  Created by SUNG on 1/13/24.
//
import UIKit

// 1. 모델 만들기 (class, struct 선언)
class Item {
    static var list: [Item] = [] // 6. 싱글턴 패턴으로 물건 목록 저장하기
    
    var name: String
    var price: Int
    var count: Int = 0
    
    init(name: String, price: Int, count: Int) {
        self.name = name
        self.price = price
        self.count = count
    }
}

class ViewController: UIViewController {
    // MARK: UI
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var savedDataLabel: UILabel!
    
    //MARK: Enum
    enum InputError: String {
        case wrongInputCount = "입력값의 개수를 확인해주세요."
        case wrongPrice = "잘못된 가격입니다."
        case wrongCount = "잘못된 개수입니다."
        case countIsNegative = "개수를 양수로 작성해주세요."
    }
    
    // MARK: Properties
    // 2. 모델 객체 생성하기
    var item: Item? = nil
    var inputError: InputError?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Functions
    func makeModel(input: String) -> Item? {
        let inputList = input.components(separatedBy: "/") //["apple", "1000", "1"]
        
        // 원소 개수 3개인지 체크
        guard inputList.count == 3 else {
            inputError = .wrongInputCount
            return nil
        }
        // 0번째는 문자열, 1,2번째는 정수인지 체크
        guard let price = Int(inputList[1]) else {
            inputError = .wrongPrice
            return nil
        }
        
        guard let count = Int(inputList[2]) else {
            inputError = .wrongCount
            return nil
        }
        
        if count < 0 {
            inputError = .countIsNegative
            return nil
        }
        
        let name = inputList[0]
        
        return Item(name: name, price: price, count: count)
    }
    
    //MARK: Actions
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        print(#function)
        
        let newItem = makeModel(input: inputTextField.text ?? "")
        
        if let newItem = newItem {
            Item.list.append(newItem)
            // 3. 생성된 객체에 값 저장하기 -> 버튼을 눌렀을 때
            item = newItem
            // 4. 3번이 정상적으로 완료되면, 텍스트필드 비워주기
            inputTextField.text = ""
            
            var resultText = ""
            //4.1 여러개의 데이터 형식에 맞춰서 label에 담아주기
            for item in Item.list {
                resultText.append("""
            물품명: \(item.name)
            가격: \(item.price)원
            개수: \(item.count)개
            -------------------------\n
            """)
                
            }
            savedDataLabel.text = resultText
        } else {
            // 5. 3번이 실패되면, 에러케이스 띄워주기
            // -> 에러케이스 띄워주기: 에러케이스 정의
            item = nil
            
            if let errorText = inputError {
                savedDataLabel.text = errorText.rawValue
            } else {
                savedDataLabel.text = "알 수 없는 에러가 발생했습니다.\n다시 시도 해주세요."
            }
        }
    }
}

