//
//  ViewController.swift
//  chayamadaKadai5_MVC
//
//  Created by 山田　天星 on 2021/07/11.
//

import UIKit

class ViewController: UIViewController {
    private var contentView: ContentView!
    private var targetNumber: Int?
    private var currentSlideNumber: Int?
    var handleNumberModel: HandleNumberModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = ContentView()
        contentView.judgeButtonDelegate = self
        contentView.frame = view.bounds
        contentView.layoutIfNeeded()
        initializeSliderValue()
        view.addSubview(contentView)

        handleNumberModel = HandleNumberModel()
        initializeTargetNumber()
        currentSlideNumber = Int(contentView.numberSetSlider.value)
    }

    private func initializeTargetNumber() {
        targetNumber = handleNumberModel?.setTargetNumber(min: Int(contentView.sliderMinValue),
                                                          max: Int(contentView.sliderMaxValue))
        contentView.targetNumberLabel.text = String(describing: targetNumber ?? 0)
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
                                    initializeTargetNumber()
                                    initializeSliderValue()
                                   })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: JudgeButtonDelegate {
    func judgeSlideNumber() {
        senderValue(currentSlideValue: contentView.numberSetSlider.value)
        guard let handleNumberModel = handleNumberModel,
              let targetNumber = targetNumber,
              let currentSlideNumber = currentSlideNumber else {
            return
        }
        let alertMessage = handleNumberModel.compareNumbers(targetNumber: targetNumber,
                                                            currentSlideNumber: currentSlideNumber)
        presentResultAlert(alertMessage: alertMessage)
    }
}

extension ViewController: SliderValueDelegate {
    func senderValue(currentSlideValue: Float) {
        contentView.numberSetSlider.setValue(currentSlideValue, animated: true)
        currentSlideNumber = Int(currentSlideValue)
    }
}
