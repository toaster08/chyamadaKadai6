//
//  Model.swift
//  chayamadaKadai5_MVC
//
//  Created by 山田　天星 on 2021/07/11.
//

import Foundation

final class HandleNumberModel {
    func setTargetNumber(min: Int, max: Int) -> Int {
        Int.random(in: min...max)
    }

    func compareNumbers(targetNumber: Int, currentSlideNumber: Int) -> String {
        if targetNumber == currentSlideNumber {
            return "あたり!\nあなたの値：\(currentSlideNumber)\n"
        } else {
            return "はずれ!\nあなたの値：\(currentSlideNumber)\n"
        }
    }
}
