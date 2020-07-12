//
//  SourcesViewController.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import UIKit
protocol NewSourceDelegate: class {
  func didTabOnSource(source: SourceModel?)
}
class SourcesViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  weak var delegate: NewSourceDelegate?
  var category: String?
  var sources: [SourceModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      getSource()
    }
  private func getSource() {
    SourceResponseModel.requestForTopNewsSource(category: category) { [weak self](response) in
      guard let strongSelf = self else {return}
      strongSelf.sources = response?.sources
      strongSelf.tableView.reloadData()
    }
  }
  @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
  }
}
extension SourcesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sources?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: SourceTVC.cellID, for: indexPath) as? SourceTVC {
      cell.titleLabel?.text = self.sources?[indexPath.row].name
      return cell
    }
        fatalError("Cell Could Not be dequeueReusableCell on \(self)")
  }
}
extension SourcesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.delegate?.didTabOnSource(source: self.sources?[indexPath.row])
    self.dismiss(animated: true, completion: nil)
  }
}
