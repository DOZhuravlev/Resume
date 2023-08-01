//
//  ViewController.swift
//  Resume
//
//  Created by Zhuravlev Dmitry on 01.08.2023.
//

import UIKit

final class ResumeViewController: UIViewController {

    // MARK: - Properties

    var isEditingSkills: Bool = false {
        didSet {
            collectionView.reloadData()
        }
    }

    var skills: [String] = ["MVI/MVVM", "Kotlin Coroutines", "Room", "OkHttp", "DataStore", "WorkManager", "custom view", "DataStore", "ООП и SOLID"]

    // MARK: - Outlets

    private let topContainerView: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bottomContainerView: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = .white


        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()


    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Иванов Иван Иванович"
        label.font = CustomFonts.sfProDisplayBold.font(size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Middle iOS-разработчик, опыт более 2-х лет"
        label.font = CustomFonts.sfProDisplayRegular.font(size: 14)
        label.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Воронеж"
        label.font = CustomFonts.sfProDisplayRegular.font(size: 14)
        label.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        imageView.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        imageView.tintColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    private let mySkillsLabel: UILabel = {
        let label = UILabel()
        label.text = "Мои навыки"
        label.font = CustomFonts.sfProDisplayMedium.font(size: 16)
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private let editSkillsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.setImage(UIImage(named: "ok"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(SkillCell.self, forCellWithReuseIdentifier: "SkillCell")
        collectionView.register(AddSkillCell.self, forCellWithReuseIdentifier: "AddSkillCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.text = "О себе"
        label.font = CustomFonts.sfProDisplayMedium.font(size: 16)
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let aboutMeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Experienced software engineer skilled in developing scalable and maintainable systems"
        label.font = CustomFonts.sfProDisplayMedium.font(size: 16)
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        title = "Профиль"
        collectionView.delegate = self
        collectionView.dataSource = self
        setupSubViews()
        setupConstraints()
        editSkills()
    }

    // MARK: - Action

    private func editSkills() {
        editSkillsButton.addTarget(self, action: #selector(editSkillsButtonTapped), for: .touchUpInside)
    }

    @objc private func editSkillsButtonTapped() {
        editSkillsButton.isSelected = !editSkillsButton.isSelected
        isEditingSkills = !isEditingSkills
        print("Button tapped!")

    }

    @objc private func toggleEditingSkills() {
        isEditingSkills = !isEditingSkills
    }

    // MARK: - Setup

    private  func setupSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(topContainerView)
        scrollView.addSubview(bottomContainerView)

        topContainerView.addSubview(photoImageView)
        topContainerView.addSubview(nameLabel)
        topContainerView.addSubview(positionLabel)
        topContainerView.addSubview(cityNameLabel)
        topContainerView.addSubview(locationImageView)

        bottomContainerView.addSubview(mySkillsLabel)
        bottomContainerView.addSubview(editSkillsButton)
        bottomContainerView.addSubview(collectionView)
        bottomContainerView.addSubview(aboutMeLabel)
        bottomContainerView.addSubview(aboutMeTextLabel)
    }

    // MARK: - Layout

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            topContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            topContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            topContainerView.bottomAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 19),

            photoImageView.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 24),
            photoImageView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 120),
            photoImageView.heightAnchor.constraint(equalToConstant: 120),

            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 64),
            nameLabel.widthAnchor.constraint(equalToConstant: 149),

            positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            positionLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            positionLabel.widthAnchor.constraint(equalToConstant: 273),

            locationImageView.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 0),
            locationImageView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 150),
            locationImageView.widthAnchor.constraint(equalToConstant: 16),
            locationImageView.heightAnchor.constraint(equalToConstant: 16),

            cityNameLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 0),
            cityNameLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 2),

            bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            bottomContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            bottomContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            bottomContainerView.heightAnchor.constraint(equalToConstant: 500),

            topContainerView.bottomAnchor.constraint(equalTo: bottomContainerView.topAnchor),

            mySkillsLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 40),
            mySkillsLabel.widthAnchor.constraint(equalToConstant: 311),
            mySkillsLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),

            editSkillsButton.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 40),
            editSkillsButton.leadingAnchor.constraint(equalTo: mySkillsLabel.trailingAnchor, constant: 8),
            editSkillsButton.widthAnchor.constraint(equalToConstant: 24),
            editSkillsButton.heightAnchor.constraint(equalToConstant: 24),

            collectionView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: mySkillsLabel.bottomAnchor, constant: 16),
            collectionView.heightAnchor.constraint(equalToConstant: 300),

            aboutMeLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            aboutMeLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),

            aboutMeTextLabel.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 8),
            aboutMeTextLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),
            aboutMeTextLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -16),
        ])
        scrollView.contentSize = CGSize(width: view.frame.width, height: topContainerView.frame.height + bottomContainerView.frame.height)
    }
}

extension ResumeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, SkillCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skills.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == skills.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddSkillCell", for: indexPath) as! AddSkillCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCell", for: indexPath) as! SkillCell
            let skill = skills[indexPath.item]
            cell.delegate = self
            cell.configure(skill: skill, index: indexPath.item)
            cell.hasDeleteButton = isEditingSkills
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == skills.count {
            return CGSize(width: 50, height: 44)
        } else {
            let skill = skills[indexPath.item]
            let skillLabelWidth = skill.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width
            let maxCellWidth = collectionView.bounds.width - 24
            let cellWidth = min(skillLabelWidth + 60, maxCellWidth) //
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCell", for: indexPath) as! SkillCell
            cell.cellWidth = cellWidth
            return CGSize(width: cellWidth, height: 44)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func deleteButtonTapped(at index: Int) {
        skills.remove(at: index)
        collectionView.reloadData()
    }
}

extension ResumeViewController: AddSkillCellDelegate {

    func addSkillButtonTapped() {
        showAddSkillAlert()
    }

    private func showAddSkillAlert() {
        let alertController = UIAlertController(title: "Добавление навыка", message: "Введите название навыка которым вы владеете", preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Введите название"
        }

        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self, weak alertController] _ in
            if let textField = alertController?.textFields?.first, let newSkill = textField.text, !newSkill.isEmpty {
                self?.skills.append(newSkill)
                print(self?.skills ?? [])
                self?.collectionView.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
