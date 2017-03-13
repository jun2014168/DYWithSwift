//
//  RoomShowViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/11.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit
import AVFoundation

class RoomShowViewController: UIViewController {
    
    fileprivate lazy var maskImageView : UIImageView = UIImageView(frame: self.view.bounds)
    
    var anchor: AnchroModel?
    
    /// 懒加载音视频会话
    fileprivate lazy var session : AVCaptureSession = AVCaptureSession()
    fileprivate lazy var videoQueue : DispatchQueue = DispatchQueue.global()
    fileprivate lazy var preview : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        setupUI()
        configureAV()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopCapture()
        dismiss(animated: true, completion: nil)
    }
}

extension RoomShowViewController {
    
    /// 设置UI
    fileprivate func setupUI() {
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = maskImageView.bounds
        maskImageView.addSubview(effectView)
        guard let icon_URL = URL(string: (anchor?.vertical_src)!) else { return }
        maskImageView.kf.setImage(with: icon_URL)
        view.addSubview(maskImageView)
    }
    
    /// 配置音视频会话
    fileprivate func configureAV() {
        // 设置session的输入源 （摄像头/话筒）
        // 获取摄像头设备
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else { return }
        let device = devices.filter({ $0.position == .front}).first
        let videoInput = try? AVCaptureDeviceInput(device: device)
        session.addInput(videoInput)
        
        // 设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
        
        // 添加图层
        preview.frame = view.bounds
        view.layer.insertSublayer(preview, above: maskImageView.layer)
        
        // 开始采集视频
        session.startRunning()
    }
    // 停止采集
    fileprivate func stopCapture() {
        preview.removeFromSuperlayer()
        session.stopRunning()
    }
    
}

extension RoomShowViewController : AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        print("采集到视频")
    }
    
}
