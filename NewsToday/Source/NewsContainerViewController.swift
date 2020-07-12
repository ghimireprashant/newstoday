//
//  NewsContainerViewController.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import UIKit
import JXSegmentedView
class NewsContainerViewController: UIViewController {
  var segmentedDataSource: JXSegmentedBaseDataSource?
  let segmentedView = JXSegmentedView()
  lazy var listContainerView: JXSegmentedListContainerView! = {
      return JXSegmentedListContainerView(dataSource: self)
  }()
  var newsDataSource: [NewsContainerDataModel] = NewsContainerDataModel.newsCategory()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      setUpPagerView()
      self.navigationItem.title = "News Today"
  }
  private func setUpPagerView() {
    let dataSource = JXSegmentedTitleDataSource()
    dataSource.isTitleColorGradientEnabled = true
    dataSource.titles = newsDataSource.map({$0.title.rawValue})
    dataSource.titleNormalColor = .black
    dataSource.titleSelectedColor = .white
    segmentedDataSource = dataSource

    let indicator = JXSegmentedIndicatorBackgroundView()
    indicator.indicatorHeight = 30
    indicator.indicatorColor = .appThemeColor
    segmentedView.indicators = [indicator]
    segmentedView.dataSource = segmentedDataSource
    segmentedView.delegate = self
    view.addSubview(segmentedView)
    
    segmentedView.listContainer = listContainerView
    view.addSubview(listContainerView)
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Source", style: UIBarButtonItem.Style.plain, target: self, action: #selector(sourceAction))
  }
  @objc func sourceAction() {
    let viewController = UIStoryboard.newsStoryboard.instantiateSourcesViewController(category: segmentedView.selectedIndex != 0 ? newsDataSource[segmentedView.selectedIndex].title.rawValue: nil)
    viewController.delegate = self
    self.navigationController?.present(viewController, animated: true, completion: nil)
  }
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
  }

  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.interactivePopGestureRecognizer?.isEnabled = true
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let guide = view.safeAreaLayoutGuide
    let height = guide.layoutFrame.size.height
    segmentedView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: 50)
    listContainerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 50, width: view.bounds.size.width, height: height - 50)
  }

}
extension NewsContainerViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
      return newsDataSource.count
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
      let viewController = newsDataSource[index].viewController
      viewController.newsType =  newsDataSource[index].title
      return viewController
    }
}
extension NewsContainerViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}
extension NewsContainerViewController: NewSourceDelegate {
  func didTabOnSource(source: SourceModel?) {
    let newsViewController = UIStoryboard.newsStoryboard.instantiateNewsViewController()
    newsViewController.newsSource = source
    self.navigationController?.pushViewController(newsViewController, animated: true)
  }
}
