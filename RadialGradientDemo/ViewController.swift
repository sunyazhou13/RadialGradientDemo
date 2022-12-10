//
//  ViewController.swift
//  RadialGradientDemo
//
//  Created by sunyazhou on 2022/12/9.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var backgroundView: UIView!
    var gradientLayer: CAGradientLayer!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundView = UIView(frame: .zero)
        let bgColor = UIColor(red: 231.0/255, green: 223.0/255, blue: 239.0/255, alpha: 1) //要想过渡自然必须保证背景颜色和渐变主颜色一致
        self.backgroundView.backgroundColor = bgColor
        self.view.addSubview(self.backgroundView)
        self.backgroundView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.size.equalTo(CGSize(width: 360, height: 70))
        }
        //径向渐变layer
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = CGRect(x: 360 * 1.15, y: -70, width: 360 * 1.15, height: 70 * 2)
        self.gradientLayer.contentsScale = UIScreen.main.scale
        self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.gradientLayer.type = .radial
        self.gradientLayer.locations = [0.25, 1]
        self.gradientLayer.colors = [UIColor(red: 203.0/255, green: 190.0/255, blue: 224.0/255, alpha: 1).cgColor, bgColor.cgColor]
        self.backgroundView.layer.addSublayer(self.gradientLayer)
        self.backgroundView.layer.cornerRadius = 5
        self.backgroundView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner];
        self.backgroundView.layer.masksToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = CGRectGetWidth(self.backgroundView.frame)
        let heigth = CGRectGetHeight(self.backgroundView.frame)
        self.gradientLayer.frame = CGRect(x: width * 1.15, y: -heigth, width: width * 1.15, height: heigth * 2)
        self.addPositionAnimation()
    }

    private func addPositionAnimation ()
    {
        if ((self.gradientLayer.animationKeys()?.contains("kAnimationKey")) != nil) {
            return;
        }
        let width = CGRectGetWidth(self.backgroundView.frame)
        let gradientWidth = CGRectGetWidth(self.gradientLayer.frame)
        let locationAniamtion: CABasicAnimation = CABasicAnimation(keyPath: "position.x")
        locationAniamtion.fromValue = gradientWidth + self.gradientLayer.anchorPoint.x * width
        locationAniamtion.toValue = -gradientWidth
        locationAniamtion.duration = 7
        locationAniamtion.repeatCount = Float.infinity
        locationAniamtion.fillMode = .forwards;
        self.gradientLayer.add(locationAniamtion, forKey: "kAnimationKey")
    }
}

