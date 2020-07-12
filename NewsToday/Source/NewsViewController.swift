//
//  NewsViewController.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import UIKit
import VerticalCardSwiper
import JXSegmentedView
import SafariServices
class NewsViewController: UIViewController {
  @IBOutlet weak var collectionView: VerticalCardSwiper!
  var newsType: NewsCategory = .top
  var numberOfPage: Int = 1
  var loadMore: Bool = false
  var newsDataSource: [TopNewsModel]?
  var newsSource: SourceModel?
private let refreshControl = UIRefreshControl()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    viewSetUp()
    refresh()
    if let source = newsSource?.name {
      self.navigationItem.title = source
    }
    getNews(pageNo: numberOfPage, newsCategory: newsType == .top ? nil: newsType.rawValue, source: self.newsSource?.id)
  }
  private func refresh() {
    refreshControl.tintColor = .white
    refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    collectionView.verticalCardSwiperView.alwaysBounceVertical = true
    collectionView.verticalCardSwiperView.refreshControl = refreshControl // iOS 10+
  }
  // MARK: - pull to refresh
  @objc
  private func didPullToRefresh(_ sender: Any) {
    getNews(pageNo: 1, showHud: false, newsCategory: newsType == .top ? nil: newsType.rawValue, source: newsSource?.id)
  }
  private func getNews(pageNo: Int, isLoadMore: Bool = false, showHud: Bool = true, newsCategory: String? = nil, source: String? = nil) {
    loadMore = false
    NewsResponseModel.requestForTopNews(page: pageNo, newsSource: source,newsCategory: newsCategory, showHud: showHud) {[weak self] (response) in
              guard let strongSelf = self else {return}
      strongSelf.refreshControl.endRefreshing()
      if !isLoadMore {
        strongSelf.newsDataSource = response?.news
        strongSelf.collectionView.reloadData()
      } else {
        if let allNews = response?.news {
          for item in allNews {
            strongSelf.newsDataSource?.append(item)
          }
        strongSelf.collectionView.reloadData()
        }
      }
      if response?.news?.count == 20 {
        strongSelf.loadMore = true
        strongSelf.numberOfPage += 1
      } else {
        strongSelf.loadMore = false
      }
    }
  }
  // MARK: - View Set Up
  private func viewSetUp() {
    collectionView.delegate = self
    collectionView.datasource = self
    collectionView.isSideSwipingEnabled = false
    collectionView.cardSpacing = 16
    collectionView.register(nib: TopNewsCVC.nib(), forCellWithReuseIdentifier: TopNewsCVC.cellID)
  }
}

// MARK: - vertical card swiper datasource
extension NewsViewController: VerticalCardSwiperDatasource {
  func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
    return newsDataSource?.count ?? 0
  }

  func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
    if let cell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: TopNewsCVC.cellID, for: index) as? TopNewsCVC {
      cell.newsModel = self.newsDataSource?[index]
      cell.tag = index
      cell.delegate = self
      return cell
    }
    fatalError("Cell Could Not be dequeueReusableCell on \(self)")
  }
}
// MARK: - vertical cart swiper delegate
extension NewsViewController: VerticalCardSwiperDelegate {
  func didTapCard(verticalCardSwiperView: VerticalCardSwiperView, index: Int) {
    if let validUrl = self.newsDataSource?[index].contentSource, validUrl.validateUrl() {
      guard let url = URL(string: validUrl) else { return }
      let svc = SFSafariViewController(url: url)
      present(svc, animated: true, completion: nil)
    } else {
      showNormalAlert(for: "Invalid URL", completionHandler: nil)
    }
  }
  func didEndScroll(verticalCardSwiperView: VerticalCardSwiperView) {
    print("End", verticalCardSwiperView.indexPathsForVisibleItems)
    guard loadMore == true, let dataCount = newsDataSource?.count, verticalCardSwiperView.indexPathsForVisibleItems.last?.row == dataCount - 1  else {return}
    getNews(pageNo: numberOfPage, isLoadMore: loadMore, showHud: false, newsCategory: newsType == .top ? nil: newsType.rawValue)
  }
}
extension NewsViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
extension NewsViewController: NewsCellDelegate {
  func didTabOnCell(cell: TopNewsCVC, action: NewsCellAction) {
    switch action {
    case .share:
      if let source = self.newsDataSource?[cell.tag].contentSource {
        let textShare = [source]
        let activityViewController = UIActivityViewController(activityItems: textShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
      } else {
        showNormalAlert(for: "Something wend wrong please try again later", completionHandler: nil)
      }
    }
  }
}
