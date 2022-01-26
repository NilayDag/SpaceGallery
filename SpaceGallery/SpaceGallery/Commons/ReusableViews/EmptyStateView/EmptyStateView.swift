//
//  EmptyStateView.swift
//  SpaceGallery
//
//  Created by Nilay Dagdemir on 26.01.2022.
//

import UIKit

class EmptyStateView: UIView {
    // MARK: - IBOutlet
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var lblEmptyState: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        loadNib()
        addSubview(contentView)
    }
}
