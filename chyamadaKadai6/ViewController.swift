//
//  ViewController.swift
//  chayamadaKadai6
//
//  Created by 山田　天星 on 2021/07/11.
//

import UIKit

class ViewController: UIViewController {
    private var contentView: ContentView!
    var handleNumberModel: HandleNumberModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = ContentView()
        contentView.judgeButtonDelegate = self
        contentView.frame = view.bounds
        contentView.layoutIfNeeded()
        initializeSliderValue()
        view.addSubview(contentView)

        handleNumberModel = HandleNumberModel(
            range: Int(contentView.sliderMinValue)...Int(contentView.sliderMaxValue)
        )

        resetTargetNumber()
    }

    private func resetTargetNumber() {
        handleNumberModel.resetCorrectAnswer()
        contentView.targetNumberLabel.text = String(describing: handleNumberModel.correctAnswer)
    }

    private func initializeSliderValue() {
        contentView.numberSetSlider.value =  (contentView.sliderMaxValue - contentView.sliderMinValue) / 2
    }

    private func presentResultAlert(alertMessage: String) {
        let alert = UIAlertController(title: "結果",
                                      message: alertMessage,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "再挑戦",
                                   style: .default,
                                   handler: { [self] _ in
                                    resetTargetNumber()
                                    initializeSliderValue()
                                   })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: JudgeButtonDelegate {
    func judgeSlideNumber() {
        guard let handleNumberModel = handleNumberModel else {
            return
        }
        let alertMessage = handleNumberModel.judge(currentSlideNumber: Int(contentView.numberSetSlider.value))
        presentResultAlert(alertMessage: alertMessage)
    }
}
