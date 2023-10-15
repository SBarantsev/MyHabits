//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Sergey on 08.08.2023.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
      
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentview = UIView()
        
        contentview.backgroundColor = .white
        contentview.translatesAutoresizingMaskIntoConstraints = false
        
        return contentview
    }()
    
    private lazy var information: UILabel = {
        let infoText = UILabel()
        
        let text = " Привычка за 21 день \n \nПрохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму: \n \n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага. \n \n2. Выдержать 2 дня в прежнем состоянии самоконтроля. \n \n3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться. \n \n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств. \n \n5. Держать планку 40 дней.Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. \n \n6. Ha 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся. \n \n Источник: psychbook.ru "

        infoText.font = UIFont.systemFont(ofSize: 17)
        infoText.numberOfLines = 0
        infoText.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: text)
        let boldTitle = (text as NSString).range(of: "Привычка за 21 день")

        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .semibold), range: boldTitle)
        
        let otherTitle = NSMakeRange(0, attributedText.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: otherTitle)
        infoText.attributedText = attributedText

        return infoText
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(information)
        scrollView.contentSize = contentView.bounds.size
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            information.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            information.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            information.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            information.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}


