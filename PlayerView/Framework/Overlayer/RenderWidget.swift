//
//  RenderWidget.swift
//  PlayerView
//
//  Created by shayanbo on 2023/6/15.
//

import Foundation
import SwiftUI
import UIKit
import AVKit

public class RenderService : Service {
    
    @ViewState fileprivate var gravity: AVLayerVideoGravity = .resizeAspect
    
    public let player = AVPlayer()
    
    public func fill() {
        gravity = .resizeAspectFill
    }
    
    public func fit() {
        gravity = .resizeAspect
    }
}

struct RenderWidget : View {
    
    var body: some View {
        WithService(RenderService.self) { service in
            RenderView(player: service.player, gravity: service.gravity)
        }
    }
}

struct RenderView : UIViewRepresentable {

    let player: AVPlayer
    let gravity: AVLayerVideoGravity
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> PlayerView {
        let playerView = PlayerView()
        playerView.player = player
        playerView.videoGravity = gravity
        return playerView
    }

    func updateUIView(_ uiView: PlayerView, context: UIViewRepresentableContext<Self>) {
        uiView.videoGravity = gravity
    }
}

class PlayerView: UIView {
    
    var videoGravity: AVLayerVideoGravity {
        get {
            let canvas = self.layer as! AVPlayerLayer
            return canvas.videoGravity
        }
        set {
            let canvas = self.layer as! AVPlayerLayer
            canvas.videoGravity = newValue
        }
    }
    
    var player: AVPlayer? {
        didSet {
            let canvas = self.layer as! AVPlayerLayer
            canvas.player = player
        }
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}