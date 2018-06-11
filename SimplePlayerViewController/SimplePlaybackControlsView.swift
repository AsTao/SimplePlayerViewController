//
//  SimplePlaybackControlsView.swift
//  Pods-SimplePlayerViewController_Example
//
//  Created by Tao on 2018/6/11.
//

import UIKit


internal func __IMG(_ named :String) -> UIImage?{
    guard let libBundle = Bundle(for: SimplePlaybackControlsView.self).path(forResource: "Resource", ofType: "bundle") else {return nil}
    guard let resource = Bundle(path: libBundle) else {return nil}
    let fix = UIScreen.main.scale > 2 ? "@3x" : "@2x"
    guard let file = resource.path(forResource: "\(named)\(fix)", ofType: "png") else {return nil}
    return UIImage(named: file)
}

class SimplePlaybackControlsView: UIView {

    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(playButton)
        self.addSubview(fullScreenButton)
        self.addSubview(slider)
        self.addSubview(leftLabel)
        self.addSubview(rightLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playButton.frame = CGRect(x: (self.frame.width - 40)/2, y: (self.frame.height-40)/2, width: 40, height: 40)
        slider.frame = CGRect(x: 40, y: self.frame.height-20, width: self.frame.width - 110, height: 10)
        leftLabel.frame = CGRect(x: 0, y: self.frame.height - 22, width: 35, height: 14)
        rightLabel.frame = CGRect(x: slider.frame.maxX + 5, y: self.frame.height - 22, width: 25, height: 14)
        fullScreenButton.frame = CGRect(x: self.frame.width - 30, y: self.frame.height-30, width: 30, height: 30)
        
    }
    
    lazy var playButton : UIButton = {
        let view = UIButton(frame: CGRect(x: 10, y: 20, width: 40, height: 40))
        view.setImage(__IMG("pause"), for: .normal)
        return view
    }()
    
    lazy var fullScreenButton : UIButton = {
        let view = UIButton(frame: CGRect(x: self.frame.width - 30, y: 20, width: 30, height: 30))
        view.setImage(__IMG("full"), for: .normal)
        return view
    }()
    
    lazy var slider : UISlider = {
        let view = UISlider(frame: CGRect(x: 50, y: self.frame.height-20, width: self.frame.width - 120, height: 5))
        view.setThumbImage(__IMG("thumb"), for: .normal)
        view.maximumTrackTintColor = UIColor(red: 255.0/232.0, green: 255.0/232.0, blue: 255.0/232.0, alpha: 0.5)
        view.minimumTrackTintColor = UIColor(red: 255.0/232.0, green: 255.0/232.0, blue: 255.0/232.0, alpha: 1)
        return view
    }()
    
    lazy var leftLabel : UILabel = {
        let view = UILabel(frame: CGRect(x: 0, y: self.frame.height - 20, width: 50, height: 14))
        view.textColor = UIColor.white
        view.textAlignment = .right
        view.font = UIFont.systemFont(ofSize: 10)
        return view
    }()
    
    lazy var rightLabel : UILabel = {
        let view = UILabel(frame: CGRect(x: 0, y: self.frame.height - 25, width: 50, height: 14))
        view.textColor = UIColor.white
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 10)
        return view
    }()
    
}

