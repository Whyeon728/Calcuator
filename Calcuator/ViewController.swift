//
//  ViewController.swift
//  Calcuator
//
//  Created by Whyeon on 2022/03/28.
//

import UIKit

enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class ViewController: UIViewController {

    @IBOutlet weak var numberOutputLabel: UILabel!
    
    var displayNumber = "" // outPutLabel에 표시될 상태값
    var firstOperand = "" // 첫번째 피연산자
    var secondOperand = "" // 새롭게 입력된 연산자
    var result = "" // 결과값
    var currentOperation: Operation = .unknown // 현재 연산자 값 저장

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) // 옵셔널 타입으로 가져와짐
        else { return }
        if self.displayNumber.count < 9 { // 최대 9자 까지 displayNumber에 저장
            self.displayNumber += numberValue // displayNumber에 입력받은 버튼 타이틀을 9자까지 넣어준다
            self.numberOutputLabel.text = self.displayNumber // 라벨에 출력
        }
    }
    
    @IBAction func tabClearButton(_ sender: UIButton) { // 모든 프로퍼티 초기화
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.numberOutputLabel.text = "0"
    }
    
    @IBAction func tabDotButton(_ sender: UIButton) {
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            // 9자리까지 출력되므로 8자리이하에서 동작하고, .을 포함하지 않는 경우에만 추가 . 중복방지
            
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            // displayNumber가 비어 있으면 0. 추가 아니면 뒤에 . 추가
            self.numberOutputLabel.text = self.displayNumber // 라벨에 출력
        }
    }
 
    //MARK: - 연산 버튼
    
    @IBAction func tabDivideButton(_ sender: UIButton) {
        self.operation(.Divide)
    }
    
    @IBAction func tabMultiplyButton(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    
    @IBAction func tabSubtractButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    
    @IBAction func tabAddButton(_ sender: UIButton) {
        self.operation(.Add)
    }
    
    @IBAction func tabEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    //MARK: - 계산담당 함수
    func operation(_ operation: Operation) {
        if self.currentOperation != .unknown {  // 현재 연산할 연산자가 없다면
            if !self.displayNumber.isEmpty { // 두번째 수가 들어왔다면
                self.secondOperand = self.displayNumber // 두번째 피연산자 저장
                self.displayNumber = "" // 다시 빈문자로 초기화
                
                guard let firstOperand = Double(self.firstOperand)
                else { return } // 첫번째 연산자 실수화
                guard let secondOperand = Double(self.secondOperand)
                else { return } // 다음 연산자 실수화
                
                switch self.currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"

                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
            
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
              
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                    
                default:
                    break
                }
                // 결과값이 1로 나누어떨어지면 (소숫점 없을경우) Int 형변환
                // truncatingRemainder 나머지 계산 함수
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = self.result // 결과값을 다시 첫번째 피연산자로 저장
                self.numberOutputLabel.text = self.result // 라벨에 출력
            }
            self.currentOperation = operation // 누적연산을 가능하게 해줌 연산자 계속해서 변경
            
        } else { // 첫번째 연산이라면
            self.firstOperand = self.displayNumber // 첫번째 피연산자에 첫번째 수
            self.currentOperation = operation // 현재 연산자에 방금 눌린 연산자를 넣어줌
            self.displayNumber = "" //다른 숫자를 누르면 새로운 숫자로 초기화
        }
    }

}

