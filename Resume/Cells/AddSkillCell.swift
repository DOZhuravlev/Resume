//
//  AddSkillCell.swift
//  Resume
//
//  Created by Zhuravlev Dmitry on 01.08.2023.
//

import Foundation
import UIKit

protocol AddSkillCellDelegate: AnyObject {
    func addSkillButtonTapped()
}

final class AddSkillCell: UICollectionViewCell {

    // MARK: - Outlets

    weak var delegate: AddSkillCellDelegate?

    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        layer.cornerRadius = 12

        addButton.addTarget(self, action: #selector(addSkillButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Action

    @objc private func addSkillButtonTapped() {
        delegate?.addSkillButtonTapped()
    }

    // MARK: - Setup

    private func setupSubviews() {
        contentView.addSubview(addButton)
    }

    // MARK: - Layout

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
