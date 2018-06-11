//
//  SimplePlayerViewController.swift
//  Pods-SimplePlayerViewController_Example
//
//  Created by Tao on 2018/6/11.
//

import UIKit
import AVKit


public class SimplePlayerViewController: UIViewController {

    @objc public var player :AVPlayer?{
        willSet{
            stop()
        }
        didSet{
            guard let control = player else {return}
            self.playerLayer.player = control
        }
    }
    
    lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer()
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.contentsScale = UIScreen.main.scale
        layer.frame = self.view.bounds
        self.view.layer.addSublayer(layer)
        return layer
    }()
    

    
    
    @objc public func play(){
        player?.play()
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(forceMoveSlideIndicator), userInfo: nil, repeats: true)
        playbackControlsView.slider.maximumValue = 0
    }
    
    @objc public func stop(){
        player?.pause()
        self.timer?.invalidate()
    }
    
    private var timer :Timer?
    @objc func forceMoveSlideIndicator(){
        guard let contrl = player else {return}
        guard contrl.status == .readyToPlay else {return}
        playbackControlsView.slider.setValue(Float(CMTimeGetSeconds(contrl.currentTime())), animated: true)
        playbackControlsView.leftLabel.text = createTimeString(time: playbackControlsView.slider.value)
        if let item = contrl.currentItem{
            playbackControlsView.slider.maximumValue = Float(CMTimeGetSeconds(item.asset.duration))
            playbackControlsView.rightLabel.text = createTimeString(time: playbackControlsView.slider.maximumValue)
        }
    }
    private func createTimeString(time: Float) -> String {
        var components = DateComponents()
        components.second = Int(max(0.0, time))
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        guard let str = formatter.string(from: components) else {return ""}
        return str
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.view.addGestureRecognizer(tapGesture)
    }

    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(tap:)))
        return tap
    }()
    
    @objc func tapGestureAction(tap :UITapGestureRecognizer){
        guard let window = UIApplication.shared.keyWindow else {return}
        if playbackControlsView.superview == nil {
            if isFullScreen {
                playbackControlsView.frame = window.bounds
                window.addSubview(playbackControlsView)
                self.perform(#selector(afterHidePlaybackControlsView), with: self, afterDelay: 3)
            }else{
                playbackControlsView.frame = self.view.bounds
                self.view.addSubview(playbackControlsView)
                self.perform(#selector(afterHidePlaybackControlsView), with: self, afterDelay: 3)
            }
        }
    }
    @objc func afterHidePlaybackControlsView(){
        hidePlaybackControlsView()
    }
    func hidePlaybackControlsView(){
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        playbackControlsView.removeFromSuperview()
    }

    lazy var playbackControlsView : SimplePlaybackControlsView = {
        let view = SimplePlaybackControlsView(frame: self.view.bounds)
        view.playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        view.fullScreenButton.addTarget(self, action: #selector(fullScreenAction), for: .touchUpInside)
        view.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return view
    }()
    
    @objc func playAction(){
        guard let pl = player else { return }
        guard pl.status == .readyToPlay else {return}
        if pl.rate == 1 {
            stop()
            playbackControlsView.playButton.setImage(__IMG("play"), for: .normal)
        }else{
            play()
            hidePlaybackControlsView()
            playbackControlsView.playButton.setImage(__IMG("pause"), for: .normal)
        }
    }
    
    @objc public var isFullScreen :Bool = false
    
    @objc func fullScreenAction(_ sender: Any) {
        hidePlaybackControlsView()
        guard let window = UIApplication.shared.keyWindow else {return}
        if !isFullScreen {
            self.playerLayer.removeFromSuperlayer()
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            window.layer.addSublayer(self.playerLayer)
            self.playerLayer.frame = window.bounds
            self.view.removeGestureRecognizer(self.tapGesture)
            window.addGestureRecognizer(self.tapGesture)
            self.isFullScreen = true
        }else{
            self.playerLayer.removeFromSuperlayer()
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            self.playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(self.playerLayer)
            self.view.addGestureRecognizer(self.tapGesture)
            window.removeGestureRecognizer(self.tapGesture)
            self.isFullScreen = false
        }
        

    }
    
    @objc func sliderValueChanged(sender :UISlider){
        guard let control = player else { return }
        if control.status == .readyToPlay{
            control.seek(to: CMTimeMake(Int64(sender.value), 1), completionHandler: { finish in})
        }
    }
    

}
