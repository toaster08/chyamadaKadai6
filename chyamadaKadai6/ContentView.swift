//
//  View.swift
//  chayamadaKadai6
//
//  Created by 山田　天星 on 2021/07/11.
//

import Foundation
import UIKit

protocol JudgeButtonDelegate: AnyObject {
    func judgeSlideNumber()
}

final class ContentView: UIView {
    var targetNumberLabel: UILabel!
    var numberSetSlider: UISlider!
    private var judgeButton: UIButton!

    private(set) var sliderMinValue: Float = 0
    private(set) var sliderMaxValue: Float = 100

    weak var judgeButtonDelegate: JudgeButtonDelegate?

    override func layoutIfNeeded() {
        setupTargetNumberLabel()
        setupSlider()
        setupLabel()
        setupButton()
    }

    private func setupTargetNumberLabel() {
        targetNumberLabel = UILabel()
        targetNumberLabel.text = "test"
        targetNumberLabel.font = UIFont.systemFont(ofSize: 30)
        targetNumberLabel.textColor = .black
        targetNumberLabel.textAlignment = .center
        self.addSubview(targetNumberLabel)

        targetNumberLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            targetNumberLabel.widthAnchor.constraint(equalToConstant: 100),
            targetNumberLabel.heightAnchor.constraint(equalToConstant: 90),
            targetNumberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            targetNumberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50)
        ])
    }

    private func setupSlider() {
        numberSetSlider = UISlider()
        numberSetSlider.frame.size = CGSize(width: self.bounds.width - 20,
                                            height: 10)
        numberSetSlider.minimumValue = sliderMinValue
        numberSetSlider.maximumValue = sliderMaxValue
        numberSetSlider.isContinuous = false
        numberSetSlider.addTarget(self, action: #selector(didChangeSliderValue(_:)), for: .valueChanged)
        self.addSubview(numberSetSlider)

        numberSetSlider.setNeedsLayout()
        numberSetSlider.layoutIfNeeded()
        numberSetSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberSetSlider.heightAnchor.constraint(equalToConstant: 10),
            numberSetSlider.topAnchor.constraint(equalTo: self.targetNumberLabel.bottomAnchor, constant: 30),
            numberSetSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            numberSetSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            numberSetSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    @objc func didChangeSliderValue(_ sender: UISlider) {
        print(sender.value)
    }

    private func setupLabel() {
        let minLabel = UILabel()
        let maxLabel = UILabel()
        minLabel.text = String(format: "%.0f", sliderMinValue)
        maxLabel.text = String(format: "%.0f", sliderMaxValue)

        let labels: [UILabel] = [minLabel, maxLabel]
        labels.forEach { $0.textColor = .black }
        labels.forEach { $0.textAlignment = .center}
        labels.forEach { self.addSubview($0) }
        labels.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            minLabel.leadingAnchor.constraint(equalTo: numberSetSlider.leadingAnchor),
            minLabel.topAnchor.constraint(equalTo: numberSetSlider.bottomAnchor, constant: 20),
            maxLabel.trailingAnchor.constraint(equalTo: numberSetSlider.trailingAnchor),
            maxLabel.topAnchor.constraint(equalTo: numberSetSlider.bottomAnchor, constant: 20)
        ])
    }

    private func setupButton() {
        judgeButton = UIButton()
        judgeButton.setTitle("判定", for: .normal)
        judgeButton.setTitleColor(.systemBlue, for: .normal)
        judgeButton.isUserInteractionEnabled = true
        self.addSubview(judgeButton)

        judgeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            judgeButton.topAnchor.constraint(equalTo: numberSetSlider.bottomAnchor, constant: 70),
            judgeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        judgeButton.addTarget(self,
                              action: #selector(didTapButton(_:)),
                              for: .touchUpInside)
    }

    @objc func didTapButton(_ sender: Any) {
        judgeButtonDelegate?.judgeSlideNumber()
    }
}
