//
//  RoundButton.swift
//  Calcuator
//
//  Created by Whyeon on 2022/03/29.
//

import UIKit

@IBDesignable // 스토리보드상에 UI가 변경되도록

class RoundButton: UIButton {

    //@IBInspectable 스토리보드상의 속성에 연결
    @IBInspectable var isRound: Bool = false { // isRound 변수 true 설정시 코너 둥글게 됨.
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 3
            }
        }
    }

}
