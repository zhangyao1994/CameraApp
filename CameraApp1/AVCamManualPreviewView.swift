//
//  AVCamManualPreviewView.swift
//  CameraApp1
//
//  Created by Yao Zhang on 11/1/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

@objc(AVCamManualPreviewView)
class AVCamManualPreviewView: UIView {
    
        override class var layerClass : AnyClass {
                return AVCaptureVideoPreviewLayer.self
            }
    
        var session: AVCaptureSession? {
                get {
                        let previewLayer = self.layer as! AVCaptureVideoPreviewLayer
                        return previewLayer.session
                    }
            
                    set {
                        let previewLayer = self.layer as! AVCaptureVideoPreviewLayer
                        previewLayer.session = newValue
                    }
            }
    
    }
