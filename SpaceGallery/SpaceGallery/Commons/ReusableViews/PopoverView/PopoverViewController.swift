//
//  PopoverViewController.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 25.01.2022.
//

import UIKit

protocol PopoverViewDelegate: AnyObject {
    func buttonPressed(_ sender: FilterOption)
}

class PopoverViewController: UIViewController, StoryboardLoadable {

    // MARK: - IBOutlets
    @IBOutlet private weak var optionsStackView: UIStackView!
    weak var delegate: PopoverViewDelegate?

    // MARK: - Properties
    private var options: [FilterOption] = [FilterOption]()
    func setupOptions(from options: [FilterOption]) {
        self.options = options
        options.forEach { option in
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
            button.setTitle(option.title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
        }
    }

    @objc private func buttonClicked(_ sender: UIButton) {
        if let senderTitle = sender.titleLabel?.text,
           let pressedOption = options.filter({ $0.title == senderTitle }).first {
            delegate?.buttonPressed(pressedOption)
        }
    }
}
