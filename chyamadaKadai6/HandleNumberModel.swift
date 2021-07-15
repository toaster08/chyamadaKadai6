//
//  Model.swift
//  chayamadaKadai6
//
//  Created by 山田　天星 on 2021/07/11.
//

import Foundation

final class HandleNumberModel {
    private(set) var correctAnswer: Int
    private let range: ClosedRange<Int>

    init(range: ClosedRange<Int>) {
        self.range = range
        self.correctAnswer = Int.random(in: range)
    }

    func resetCorrectAnswer() {
        self.correctAnswer = Int.random(in: range)
    }

    func judge(currentSlideNumber: Int) -> String {
        if correctAnswer == currentSlideNumber {
            return "あたり!\nあなたの値：\(currentSlideNumber)\n"
        } else {
            return "はずれ!\nあなたの値：\(currentSlideNumber)\n"
        }
    }
}
