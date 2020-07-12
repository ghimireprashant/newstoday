//
//  AnimatedButton.swift
//
//  Created by Prashant Ghimire on 5/7/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
open class AnimatedButton: UIButton {
  /// Start animation duration.
  open var beginAnimationDuration: Double = 0.2
  /// End animation duration.
  open var endAnimationDuration: Double = 0.25
  /// Animation Spring velocity.
  open var initialSpringVelocity: Float = 6.0
  /// Animation Spring Damping.
  open var usingSpringWithDamping: Float = 0.2
  /// A flag which indicates if the button is in the middle of an animation.
  internal (set) open var isAnimating = false
  /// Should interaction be animated.
  @IBInspectable
  open var animateInteraction: Bool = false
  /// Should highlight on interaction.
  @IBInspectable
  open var highlightOnTouch: Bool = true
  /// Animation Scale.
  open var animationScale: CGFloat = 0.95
  /// Corner radius.
  @IBInspectable
  open var cornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
    }
  }
  @IBInspectable
  open var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  @IBInspectable
  open var borderColor: UIColor = .clear {
    didSet {
      layer.borderColor = borderColor.cgColor
    }
  }
  @IBInspectable  var enableShadow: Bool = false
  @IBInspectable  var shadowColor: UIColor = .white
  ///Use given corner radius. if set to false will use the bounds.height / 2
  @IBInspectable
  open var useCornerRadius: Bool = true {
    didSet {
      layer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
    }
  }
  /// Shadow Opacity of the button
  @IBInspectable
  open var shadowOpacity: Float = 0.2 {
    didSet {
      layer.shadowOpacity = shadowOpacity
    }
  }
  @IBInspectable var labelUnderImage: Bool = false
  // MARK: - gradient layer
  @IBInspectable var gradientEnabled: Bool = false {
    didSet {
      setupGradient()
    }
  }
  // MARK: - Gradient Background
  @IBInspectable var gradientStartColor: UIColor = UIColor.blue {
    didSet {
      setupGradient()
    }
  }
  @IBInspectable var gradientEndColor: UIColor = UIColor.green {
    didSet {
      setupGradient()
    }
  }
  @IBInspectable var gradientHorizontal: Bool = false {
    didSet {
      setupGradient()
    }
  }
  var groupName: String = ""
  override open func layoutSubviews() {
    super.layoutSubviews()
    self.titleLabel?.numberOfLines = 2
    gradient?.frame = self.layer.bounds
    if let gradientLayer = gradient {
      gradientLayer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
    }
    self.layer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
    self.layer.masksToBounds = false
    if enableShadow {
      self.layer.shadowColor = shadowColor.cgColor
      self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
      self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
      self.layer.shadowOpacity = 0.5
      self.layer.shadowRadius = 1.0
    }
    self.imageView?.contentMode = .scaleAspectFit
    if labelUnderImage {
      if let imageView = self.imageView {
        imageView.frame.origin.x = (self.bounds.size.width - imageView.frame.size.width) / 2.0
        imageView.frame.origin.y = 0.0
      }
      if let titleLabel = self.titleLabel {
        titleLabel.frame.origin.x = (self.bounds.size.width - titleLabel.frame.size.width) / 2.0
        titleLabel.frame.origin.y = self.bounds.size.height - titleLabel.frame.size.height
      }
    }
  }
  var gradient: CAGradientLayer?
  func setupGradient() {
    guard gradientEnabled != false else {
      return
    }
    gradient?.removeFromSuperlayer()
    gradient = CAGradientLayer()
    guard let gradient = gradient else { return }
    gradient.frame = self.layer.bounds
    gradient.colors = [gradientStartColor.cgColor, gradientEndColor.cgColor]
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint = gradientHorizontal ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 1)
    gradient.cornerRadius = self.cornerRadius
    self.layer.insertSublayer(gradient, below: self.imageView?.layer)
  }
  /// Shadow radius of the button.
  @IBInspectable
  open var shadowRadius: CGFloat = 1.0 {
    didSet {
      layer.shadowRadius = shadowRadius
    }
  }
  /// Init with frame.
  ///
  /// - Parameter frame: The frame of the button.
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.imageView?.contentMode = .scaleAspectFill
  }
  /// Init with coder
  ///
  /// - Parameter coder: NIB Coder
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  /// Called when adding the view.
  override open func didMoveToSuperview() {
    if !isAnimating {
      layer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
    }
    layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    layer.shadowOpacity = shadowOpacity
    layer.shadowRadius = shadowRadius
  }
  open override var isHighlighted: Bool {
    set {
      if highlightOnTouch {
        self.alpha = newValue ? 0.5 : 1
      }
      super.isHighlighted = newValue
    }
    get {
      return super.isHighlighted
    }
  }
}
extension AnimatedButton {
  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self.animateInteraction {
      isAnimating = true
      UIView.animate(withDuration: self.beginAnimationDuration, animations: {
        self.transform = CGAffineTransform(scaleX: self.animationScale, y: self.animationScale)
      }, completion: { (complete) in
        self.isAnimating = false
      })
    }
    super.touchesBegan(touches, with: event)
  }
  override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    let tap: UITouch = touches.first!
    let point = tap.location(in: self)
    if !self.bounds.contains(point) {
      if self.animateInteraction {
        isAnimating = true
        UIView.animate(withDuration: self.beginAnimationDuration, animations: {
          self.transform = .identity
        }, completion: { (complete) in
          self.isAnimating = false
        })
      }
    } else {
      if self.animateInteraction {
        isAnimating = true
        UIView.animate(withDuration: self.beginAnimationDuration, animations: {
          self.transform = CGAffineTransform(scaleX: self.animationScale, y: self.animationScale)
        }, completion: { (complete) in
          self.isAnimating = false
        })
      }
    }
    super.touchesMoved(touches, with: event)
  }
  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self.animateInteraction {
      isAnimating = true
      UIView.animate(withDuration: self.endAnimationDuration,
                     delay: 0,
                     usingSpringWithDamping: CGFloat(self.usingSpringWithDamping),
                     initialSpringVelocity: CGFloat(self.initialSpringVelocity),
                     options: .allowUserInteraction,
                     animations: {
                      self.transform = .identity
      }, completion: { (complete) in
        self.isAnimating = false
      })
    }
    super.touchesEnded(touches, with: event)
  }
  override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self.animateInteraction {
      isAnimating = true
      UIView.animate(withDuration: self.endAnimationDuration,
                     delay: 0,
                     usingSpringWithDamping: CGFloat(self.usingSpringWithDamping),
                     initialSpringVelocity: CGFloat(self.initialSpringVelocity),
                     options: .allowUserInteraction,
                     animations: {
                      self.transform = .identity
      }, completion: { (complete) in
        self.isAnimating = false
      })
    }
    super.touchesCancelled(touches, with: event)
  }
}
