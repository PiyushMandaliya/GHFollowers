//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-19.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for url: String)
}

class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate: GFRepoItemVCDelegate!

    
    init(user: User, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate   = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)

        actionButton.set(color: .systemPurple, title: "GitHub Profile", image: SFSymbol.profileButton!)
    }
    
    override func actionButtonTap() {
        delegate.didTapGitHubProfile(for: user.htmlUrl!)
    }
}
