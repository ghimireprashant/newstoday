//
//  TopNewsCVC.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import UIKit
import UIKit
import VerticalCardSwiper
protocol NewsCellDelegate: class {
  func didTabOnCell(cell: TopNewsCVC, action: NewsCellAction)
}
enum NewsCellAction {
  case share
}
class TopNewsCVC: CardCell {
  @IBOutlet weak var newsCateogryLabel: UILabel!
  @IBOutlet weak var newsTitleString: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var artworkImageView: UIImageView!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  weak var delegate: NewsCellDelegate?
  static let cellID: String = "TopNewsCVC"
  class func nib() -> UINib {
    return UINib(nibName: self.cellID, bundle: nil)
  }
  var newsModel: TopNewsModel? {
    didSet {
      self.newsCateogryLabel.text = newsModel?.name
      self.newsTitleString.text = newsModel?.title
      self.dateLabel.text = newsModel?.date
      self.authorLabel.text = "Author: \(newsModel?.author ?? "")"
      self.descriptionLabel.text = newsModel?.description
      self.artworkImageView.setURLImage(imageURL: newsModel?.imageURL)
    }
  }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  @IBAction func shareAction(_ sender: Any) {
    self.delegate?.didTabOnCell(cell: self, action: .share)
  }
  override func prepareForReuse() {
      super.prepareForReuse()
  }
  override func layoutSubviews() {
      self.layer.cornerRadius = 12
      super.layoutSubviews()
  }
}
