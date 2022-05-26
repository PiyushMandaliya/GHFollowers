//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-06.
//

import UIKit



class FollowersListVC: GFDataLoadingVC {
    
    enum Section { case main }
    
    var username: String!
    var followers: [Follower]           = []
    var fileredFollowers: [Follower]    = []
    var page                            = 1
    var hasMoreFollowers                = true
    var isSearching                     = false
    var isLoadingMoreFollowers          = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController                     = UISearchController()
        searchController.searchResultsUpdater    = self
        searchController.searchBar.placeholder   = "Search for a username"
        navigationItem.searchController          = searchController
    }
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        //MARK: -  Using the async await
        
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                updateUI(with: followers)
                dismissLoadingView()
            } catch {
                dismissLoadingView()
                if let gfError = error as? GFError {
                    presentGFAlert(title: "Bad Stuff Happend", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
            }
        }
        
        // OR
        
//        guard let followers = try? await NetworkManager.shared.getFollowers(for: username, page: page) else {
//            presentDefaultError()
//            dismissLoadingView()
//            return
//        }
//
//        updateUI(with: followers)
//        dismissLoadingView()
  
        //MARK: -  Using the clouser
        
//        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
//
//            guard let self = self else { return }
//            self.dismissLoadingView()
//
//            switch result {
//            case .success(let followers):
//                self.updateUI(with: followers)
//
//            case .failure(let error):
//                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
//            }
//            self.isLoadingMoreFollowers = false
//        }
    }
    
    func updateUI(with followers: [Follower]) {
        if followers.count < 50 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
            let message = "This user doesn't have any follower. Go follow them 😞."
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
        }
        self.updateData(on: self.followers)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    @objc func addButtonTapped(){
        self.showLoadingView()
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                addUserToFavorites(user: user)
                dismissLoadingView()
            } catch {
                dismissLoadingView()
                if let gfError = error as? GFError {
                    self.presentGFAlert(title: "Bad Stuff Happend", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
            }
        }
    }
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.presentGFAlert(title: "Success", message: "You have successfully favorite user 🎉.", buttonTitle: "Hooray!")
                return
            }
            self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}

extension FollowersListVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray         = isSearching ? fileredFollowers : followers
        let follower            = activeArray[indexPath.row]
        
        let userInfoVC          = UserInfoVC()
        userInfoVC.username     = follower.login
        userInfoVC.delegate     = self
        let navController       = UINavigationController(rootViewController: userInfoVC)
        present(navController, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            if !isLoadingMoreFollowers {
                page += 1
                getFollowers(username: username, page: page)
            }
        }
    }
}


extension FollowersListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            fileredFollowers.removeAll()
            updateData(on: self.followers)
            isSearching = false
            return
        }
        isSearching = true
        fileredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: fileredFollowers)
    }
}

extension FollowersListVC: UserInfoVCDelegate {
    func didRequestFollower(for username: String) {
        // get Follower for user
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        fileredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: self.username, page: page )
    }
}
