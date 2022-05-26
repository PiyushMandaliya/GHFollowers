//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-19.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for username: String)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemVCDelegate!

    
    init(user: User, delegate: GFFollowerItemVCDelegate) {
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

    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)

        actionButton.set(color: .systemGreen, title: "GitHub Followers", image: SFSymbol.followerButton!)
    }
    
    override func actionButtonTap() {
        guard user.followers != 0 else {
            presentGFAlert(title: "No Followers", message: "This user has no folloers. What a shame 😔.", buttonTitle: "Ok")
            return
        }
        delegate.didTapGetFollowers(for: user.login)
    }
}
