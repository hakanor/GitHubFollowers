//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 13.03.2024.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    //MARK: - Properties
    var username: String!
    var followers: [Follower] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var page = 1
    var hasMoreFollowers = true
    
    //MARK: - Subviews
    var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
        configureDataSource()
        getFollowers(username: username, page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray4
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as! FollowerCell
            cell.setCell(follower: follower)
            return cell
        })
    }
    
    private func updateData() {
        // create snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        // add sections to snapshot
        snapshot.appendSections([.main])
        // add items to snapshot
        snapshot.appendItems(followers)
        //dispatchQueue gerekebilir.
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func getFollowers(username: String, page: Int) {
        Task {
            showLoadingView()
            let followersFromRequest = try await NetworkProvider.shared.execute(GetFollowersRequest(username: username, page: page))
            // our network call request 100 followers
            if followersFromRequest.count < 100 { hasMoreFollowers = false }
            followers.append(contentsOf: followersFromRequest)
            dismissLoadingView()
            if self.followers.isEmpty {
                let message = "This user doesn't have any followers."
                showEmptyStateView(with: message, in: self.view)
                return
            }
            updateData()
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
