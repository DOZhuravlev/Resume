//
//  SkillsCell.swift
//  Resume
//
//  Created by Zhuravlev Dmitry on 01.08.2023.
//

import UIKit

protocol SkillCellDelegate: AnyObject {
    func deleteButtonTapped(at index: Int)
}

final class SkillCell: UICollectionViewCell {

    // MARK: - Properties

    var cellWidth: CGFloat = 0 {
            didSet {
                // При изменении ширины ячейки, обновляем соответствующие constraint'ы
                NSLayoutConstraint.deactivate(constraintsWithDeleteButton)
                NSLayoutConstraint.deactivate(constraintsWithoutDeleteButton)

                if hasDeleteButton {
                    NSLayoutConstraint.activate(constraintsWithDeleteButton)
                } else {
                    NSLayoutConstraint.activate(constraintsWithoutDeleteButton)
                }
            }
        }

    weak var delegate: SkillCellDelegate?

    private var constraintsWithDeleteButton: [NSLayoutConstraint] = []
    private var constraintsWithoutDeleteButton: [NSLayoutConstraint] = []
    private var index: Int = 0

    var hasDeleteButton: Bool = false {
        didSet {
            if hasDeleteButton {
                NSLayoutConstraint.deactivate(constraintsWithoutDeleteButton)
                NSLayoutConstraint.activate(constraintsWithDeleteButton)
            } else {
                NSLayoutConstraint.deactivate(constraintsWithDeleteButton)
                NSLayoutConstraint.activate(constraintsWithoutDeleteButton)
            }
            deleteButton.isHidden = !hasDeleteButton
        }
    }

    // MARK: - Outlets

    private let skillLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.sfProDisplayRegular.font(size: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        layer.cornerRadius = 12
        backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Action

    func configure(skill: String, index: Int) {
        skillLabel.text = skill
        self.index = index
    }

    @objc private func deleteButtonTapped() {
        delegate?.deleteButtonTapped(at: index)
    }
    // MARK: - Setup


    private func setupSubviews() {
        contentView.addSubview(skillLabel)
        contentView.addSubview(deleteButton)
    }

    // MARK: - Layout

    private func setupConstraints() {
        constraintsWithDeleteButton = [
            skillLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            skillLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            skillLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            deleteButton.leadingAnchor.constraint(equalTo: skillLabel.trailingAnchor, constant: -10),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 14),
            deleteButton.heightAnchor.constraint(equalToConstant: 14)
        ]

        constraintsWithoutDeleteButton = [
            skillLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            skillLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            skillLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            skillLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ]
        cellWidth = contentView.bounds.width
    }
}
