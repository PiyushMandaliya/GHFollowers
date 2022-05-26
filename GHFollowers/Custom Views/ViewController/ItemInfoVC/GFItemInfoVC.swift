//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-19.
//

import UIKit

class GFItemInfoVC: UIViewController {

    var user: User!
    
    let stackView           = UIStackView()
    let itemInfoViewOne     = GFItemInfoView()
    let itemInfoViewTwo     = GFItemInfoView()
    let actionButton        = GFButton()
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionButton()
    }
    
    func configureBackgroundView(){
        view.layer.cornerRadius     = 18
        view.backgroundColor        = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTap), for: .touchUpInside)
    }
  
    @objc func actionButtonTap() {
        
    }
    
    private func layoutUI(){
        view.addSubviews(stackView,actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
