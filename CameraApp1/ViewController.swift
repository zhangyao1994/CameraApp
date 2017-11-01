//
//  ViewController.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 6/27/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit
import FirebaseAuth
import AVFoundation

private var CapturingStillImageContext = 0 //### iOS < 10.0
private var SessionRunningContext = 0
private var LensPositionContext = 0
private var ExposureDurationContext = 0
private var ISOContext = 0
private var DeviceWhiteBalanceGainsContext = 0
private var ExposureTargetBiasContext = 0
private var ExposureTargetOffsetContext = 0

private protocol AVCaptureDeviceDiscoverySessionType: class {
    @available(iOS 10.0, *)
    var devices: [AVCaptureDevice]! { get }
}

@available(iOS 10.0, *)
extension AVCaptureDeviceDiscoverySession: AVCaptureDeviceDiscoverySessionType {}

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var previewView1: AVCamManualPreviewView!
    
    @IBOutlet weak var manualHUD: UIView!
    @IBOutlet weak var focusHUD: UIView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var focusPositionSlider: UISlider!
    @IBOutlet weak var focusPositionValue: UILabel!
    
    @IBOutlet weak var viewPhotos: UIButton!
    
    @IBOutlet weak var cameraButton: RoundButton!
    
    @IBOutlet weak var exposureHUD: UIView!

    @IBOutlet weak var exposureDurationSlider: UISlider!
    
    @IBOutlet weak var exposureDurationValue: UILabel!
    @IBOutlet weak var isoLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var exposureISOSlider: UISlider!
    @IBOutlet weak var exposureISOValue: UILabel!
    
    @IBOutlet weak var capturedImage: UIImageView!
    
    @IBOutlet weak var capturedImage2: UIImageView!

    var secondImage: Bool = false;
    
    @IBOutlet weak var whitebalanceHUD: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var whitebalanceTemperatureSlider: UISlider!
    
    
    @IBOutlet weak var temperatureValue: UILabel!
    @IBOutlet weak var tintLabel: UILabel!
    @IBOutlet weak var whitebalanceTintSlider: UISlider!
    @IBOutlet weak var tintValue: UILabel!
    @IBOutlet weak var whiteImage: UIImageView!
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var switchSetting: UISegmentedControl!
    private var isSessionRunning: Bool = false
    
    @IBOutlet weak var biasSlider: UISlider!
    @IBOutlet weak var offsetSlider: UISlider!
    
    private var backgroundRecordingID: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    dynamic var videoDeviceInput: AVCaptureDeviceInput?
    private var videoDeviceDiscoverySession: AVCaptureDeviceDiscoverySessionType?

    dynamic var device1 = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    dynamic var session: AVCaptureSession!
    dynamic var stillImageOutput: AVCapturePhotoOutput?
    var previewViewLayer: AVCaptureVideoPreviewLayer?
    var sessionQueue: DispatchQueue!
//    private var setupResult: AVCamManualSetupResult = .success
    private let kExposureDurationPower = 5.0
    private let kExposureMinimumDuration = 1.0/1000
    var timer = Timer()
    var cameraTimer = Timer()
    var Timestamp: String {
        return "\(NSDate().timeIntervalSince1970 * 1000)"
    }
    var imagesList = [AVAsset]()
    var image = UIImage()
    var image2 = UIImage()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.focusHUD.isHidden = true
        self.exposureHUD.isHidden = true
        self.whitebalanceHUD.isHidden = true

        
        view.backgroundColor = .black
        print(Auth.auth().currentUser?.email! as Any)
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetPhoto
        stillImageOutput = AVCapturePhotoOutput()
        
        self.view.bringSubview(toFront: manualHUD)
        self.view.bringSubview(toFront: switchSetting)
        self.view.sendSubview(toBack: previewView1)


        if #available(iOS 10.0, *) {
            let deviceTypes: [AVCaptureDeviceType] = [.builtInWideAngleCamera, .builtInDuoCamera, .builtInTelephotoCamera]
            self.videoDeviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: deviceTypes, mediaType: AVMediaTypeVideo, position: .unspecified)
        }



        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        if let input = try? AVCaptureDeviceInput(device: backCamera) {
            if (session?.canAddInput(input))! {
                session?.addInput(input)
                if (session?.canAddOutput(stillImageOutput))! {
                    session?.addOutput(stillImageOutput!)
                    
                    previewViewLayer = AVCaptureVideoPreviewLayer(session: session)
                    previewViewLayer?.frame = previewView1.bounds
                    previewView1.layer.addSublayer(previewViewLayer!)
                    session?.startRunning()
                }
            } else {
                print("Error : captureSesssion.canAddInput")
            }
        } else {
            print("Unknown Error")
        }
 
}
    

@IBAction func changeHUD(_ sender: Any) {
    
    if switchSetting.selectedSegmentIndex == 0 {
        self.focusHUD.isHidden = true
        self.exposureHUD.isHidden = true
        self.whitebalanceHUD.isHidden = true

    }
    
    if switchSetting.selectedSegmentIndex == 1 {
        self.focusPositionSlider.isEnabled = true
        self.focusPositionSlider.isHidden = false
        self.focusHUD.isHidden = false
        self.exposureHUD.isHidden = true
        self.whitebalanceHUD.isHidden = true
        self.view.bringSubview(toFront: focusPositionSlider)

    
    }
    if switchSetting.selectedSegmentIndex == 2 {
        self.exposureDurationSlider.isEnabled = true
        self.exposureDurationSlider.isHidden = false
        self.exposureISOSlider.isEnabled = true
        self.exposureISOSlider.isHidden = false
        self.exposureHUD.isHidden = false
        self.focusHUD.isHidden = true
        self.whitebalanceHUD.isHidden = true
        

    }
    if switchSetting.selectedSegmentIndex == 3 {
        self.whitebalanceTemperatureSlider.isEnabled = true
        self.whitebalanceTemperatureSlider.isHidden = false
        self.whitebalanceTintSlider.isEnabled = true
        self.whitebalanceTintSlider.isHidden = false
        self.focusHUD.isHidden = true
        self.exposureHUD.isHidden = true
        self.whitebalanceHUD.isHidden = false
        
    }
    
    
}

private func set(_ slider: UISlider, highlight color: UIColor) {
        
        slider.tintColor = color
        
        if slider === self.focusPositionSlider {
            self.positionLabel.textColor = slider.tintColor
            self.focusPositionValue.textColor = slider.tintColor
        } else if slider === self.exposureDurationSlider {
            self.durationLabel.textColor = slider.tintColor
            self.exposureDurationValue.textColor = slider.tintColor
        } else if slider === self.exposureISOSlider {
            self.isoLabel.textColor = slider.tintColor
            self.exposureISOValue.textColor = slider.tintColor
        } else if slider === self.whitebalanceTemperatureSlider {
            self.temperatureValue.textColor = slider.tintColor
            self.temperatureLabel.textColor = slider.tintColor
        } else if slider === self.whitebalanceTintSlider {
            self.tintLabel.textColor = slider.tintColor
            self.tintValue.textColor = slider.tintColor
        }
    }
    
    @IBAction func sliderTouchBegan(_ slider: UISlider) {
        self.set(slider, highlight: UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0))
    }
    
    @IBAction func sliderTouchEnded(_ slider: UISlider) {
        self.set(slider, highlight: UIColor.yellow)
    }
    

    
private func configureManualHUD() {
        // Manual focus controls
    
    
        self.focusPositionSlider.minimumValue = 0.0
        self.focusPositionSlider.maximumValue = 1.0
        self.focusPositionSlider.value = self.device1?.lensPosition ?? 0
// Use 0-1 as the slider range and do a non-linear mapping from the slider value to the actual device exposure duration
        self.exposureDurationSlider.minimumValue = 0
        self.exposureDurationSlider.maximumValue = 1
        let exposureDurationSeconds = CMTimeGetSeconds(self.device1?.exposureDuration ?? CMTime())
        let minExposureDurationSeconds = max(CMTimeGetSeconds(self.device1?.activeFormat.minExposureDuration ?? CMTime()), kExposureMinimumDuration)
        let maxExposureDurationSeconds = CMTimeGetSeconds(self.device1?.activeFormat.maxExposureDuration ?? CMTime())
        // Map from duration to non-linear UI range 0-1
        let p = (exposureDurationSeconds - minExposureDurationSeconds) / (maxExposureDurationSeconds - minExposureDurationSeconds) // Scale to 0-1
        self.exposureDurationSlider.value = Float(pow(p, 1 / kExposureDurationPower)) // Apply inverse power
        self.exposureDurationSlider.isEnabled = false
    
        self.exposureISOSlider.minimumValue = self.device1?.activeFormat.minISO ?? 0.0
        self.exposureISOSlider.maximumValue = self.device1?.activeFormat.maxISO ?? 0.0
        self.exposureISOSlider.value = self.device1?.iso ?? 0.0
        self.exposureISOSlider.isEnabled = false
    
        self.biasSlider.minimumValue = self.device1?.minExposureTargetBias ?? 0.0
        self.biasSlider.maximumValue = self.device1?.maxExposureTargetBias ?? 0.0
        self.biasSlider.value = self.device1?.exposureTargetBias ?? 0.0
        self.biasSlider.isEnabled = true
    
        self.offsetSlider.minimumValue = self.device1?.minExposureTargetBias ?? 0.0
        self.offsetSlider.maximumValue = self.device1?.maxExposureTargetBias ?? 0.0
        self.offsetSlider.value = self.device1?.exposureTargetOffset ?? 0.0
        self.offsetSlider.isEnabled = false


    
        // Manual white balance controls
    
        let whiteBalanceGains = self.device1?.deviceWhiteBalanceGains ?? AVCaptureWhiteBalanceGains()
        let whiteBalanceTemperatureAndTint = self.device1?.temperatureAndTintValues(forDeviceWhiteBalanceGains: whiteBalanceGains) ?? AVCaptureWhiteBalanceTemperatureAndTintValues()
        
        self.whitebalanceTemperatureSlider.minimumValue = 3000
        self.whitebalanceTemperatureSlider.maximumValue = 8000
        self.whitebalanceTemperatureSlider.value = whiteBalanceTemperatureAndTint.temperature
    
        
        self.whitebalanceTintSlider.minimumValue = -150
        self.whitebalanceTintSlider.maximumValue = 150
        self.whitebalanceTintSlider.value = whiteBalanceTemperatureAndTint.tint
    
    
    }
    
    @IBAction func changeLensPosition(_ control: UISlider) {
        
        do {
            try self.device1!.lockForConfiguration()
            self.device1!.setFocusModeLockedWithLensPosition(control.value, completionHandler: nil)
            self.device1!.unlockForConfiguration()
        } catch let error {
            NSLog("Could not lock device for configuration: \(error)")
        }
    }
    
    @IBAction func changeExposureDuration(_ control: UISlider) {
        
        let p = pow(Double(control.value), kExposureDurationPower) // Apply power function to expand slider's low-end range
        let minDurationSeconds = max(CMTimeGetSeconds(self.device1!.activeFormat.minExposureDuration), kExposureMinimumDuration)
        let maxDurationSeconds = CMTimeGetSeconds(self.device1!.activeFormat.maxExposureDuration)
        let newDurationSeconds = p * ( maxDurationSeconds - minDurationSeconds ) + minDurationSeconds; // Scale from 0-1 slider range to actual duration
        
        do {
            try self.device1!.lockForConfiguration()
 //           self.device1!.setExposureModeCustomWithDuration(CMTimeMakeWithSeconds(newDurationSeconds, 1000*1000*1000), iso: AVCaptureISOCurrent, completionHandler: nil)
            self.device1!.unlockForConfiguration()
        } catch let error {
            NSLog("Could not lock device for configuration: \(error)")
        }
    }
    
    @IBAction func changeISO(_ control: UISlider) {
        
        do {
            try self.device1!.lockForConfiguration()
//            self.device1!.setExposureModeCustomWithDuration(AVCaptureExposureDurationCurrent, iso: control.value, completionHandler: nil)
            self.device1!.unlockForConfiguration()
        } catch let error {
            NSLog("Could not lock device for configuration: \(error)")
        }
    }

    @IBAction func changeExposureTargetBias(_ control: UISlider) {
        do {
            try self.device1!.lockForConfiguration()
            self.device1!.setExposureTargetBias(control.value, completionHandler: nil)
            self.device1!.unlockForConfiguration()
        } catch let error {
            NSLog("Could not lock device for configuration: \(error)")
        }

    }
    
    
    private func setWhiteBalanceGains(_ gains: AVCaptureWhiteBalanceGains) {
        do {
            try self.device1!.lockForConfiguration()
            let normalizedGains = self.normalizedGains(gains)
            self.device1!.setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains(normalizedGains, completionHandler: nil)
            self.device1!.unlockForConfiguration()
        } catch let error {
            NSLog("Could not lock device for configuration: \(error)")
        }
    }
    
    
    @IBAction func changeTemperature(_: AnyObject) {
        let temperatureAndTint = AVCaptureWhiteBalanceTemperatureAndTintValues(
            temperature: self.whitebalanceTemperatureSlider.value,
            tint: self.whitebalanceTintSlider.value
        )
        self.setWhiteBalanceGains(self.device1!.deviceWhiteBalanceGains(for: temperatureAndTint))
    }
    
    @IBAction func changeTint(_: AnyObject) {
        let temperatureAndTint = AVCaptureWhiteBalanceTemperatureAndTintValues(
            temperature: self.whitebalanceTemperatureSlider.value,
            tint: self.whitebalanceTintSlider.value
        )
        
        self.setWhiteBalanceGains(self.device1!.deviceWhiteBalanceGains(for: temperatureAndTint))
    }
    private func normalizedGains(_ gains: AVCaptureWhiteBalanceGains) -> AVCaptureWhiteBalanceGains {
        var g = gains
 
        g.redGain = max(1.0, g.redGain)
        g.greenGain = max(1.0, g.greenGain)
        g.blueGain = max(1.0, g.blueGain)
        
        g.redGain = min(self.device1!.maxWhiteBalanceGain, g.redGain)
        g.greenGain = min(self.device1!.maxWhiteBalanceGain, g.greenGain)
        g.blueGain = min(self.device1!.maxWhiteBalanceGain, g.blueGain)
   
        return g
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 10.0, *)
    @IBAction func pressCamera(_ sender: Any) {
        let rawFormat = 0
        let makeSettings = AVCaptureAutoExposureBracketedStillImageSettings.autoExposureSettings
        let bracketedStillImageSettings = [2, 2].map { makeSettings(Float($0))! }
        let bracketedSettings: [AVCaptureBracketedStillImageSettings]
        bracketedSettings = [AVCaptureAutoExposureBracketedStillImageSettings.autoExposureSettings(withExposureTargetBias: AVCaptureExposureTargetBiasCurrent)]


        let settings = AVCapturePhotoBracketSettings(rawPixelFormatType: OSType(rawFormat), processedFormat: nil, bracketedSettings: bracketedStillImageSettings)
        
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        self.secondImage = false;
        settings.previewPhotoFormat = previewFormat
        stillImageOutput?.capturePhoto(with: settings, delegate: self)
        
        
        whiteImage.image = UIImage(named: "white")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                          didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                          previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                          resolvedSettings: AVCaptureResolvedPhotoSettings,
                          bracketSettings: AVCaptureBracketedStillImageSettings?,
                          error: Error?){
        if let error = error {
            print("error occure : \(error.localizedDescription)")
        }
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingRawPhoto rawSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                     resolvedSettings: AVCaptureResolvedPhotoSettings,
                     bracketSettings: AVCaptureBracketedStillImageSettings?,
                     error: Error?){
        if let error = error {
            print("error occure : \(error.localizedDescription)")
        }
    } 

    // called every time interval from the timer
    func delayedAction() {
        print("enter delayedAction")
        whiteImage.image = UIImage(named: "asfalt-light")
        let settings = AVCapturePhotoSettings()
        
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        self.secondImage = true;
        settings.previewPhotoFormat = previewFormat
        stillImageOutput?.capturePhoto(with: settings, delegate: self)
        print("2nd image taken")

    }

    @IBAction func doLogout(_ sender: Any) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "logout", sender: self)
    }
    
    //call back from take picture
    func capture(_ stillImageOutput: AVCapturePhotoOutput,didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let error = error {
            print("error occure : \(error.localizedDescription)")
        }
        if  let sampleBuffer = photoSampleBuffer,
            let previewBuffer = previewPhotoSampleBuffer,
            let dataImage =  AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer:  sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            print("print inside capture:"+self.secondImage.description)
            print(UIImage(data: dataImage)?.size as Any)
            let dataProvider = CGDataProvider(data: dataImage as CFData)
            let cgImageRef: CGImage! = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
            
            if self.secondImage {
                self.image2 = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.right)
                print("2nd image done")
                self.performSegue(withIdentifier: "showpicture", sender: self)
            } else {
                self.image = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.right)
                self.capturedImage.image = self.image
                print("1st image done")
                self.secondImage = true;
            }
            
        } else {
            print("Unknown Error")
        }
    }
    
    private func addObservers() {
        self.addObserver(self, forKeyPath: "device1.lensPosition", options: .new, context: &LensPositionContext)
        self.addObserver(self, forKeyPath: "device1.exposureDuration", options: .new, context: &ExposureDurationContext)
        self.addObserver(self, forKeyPath: "device1.ISO", options: .new, context: &ISOContext)
        self.addObserver(self, forKeyPath: "device1.deviceWhiteBalanceGains", options: .new, context: &DeviceWhiteBalanceGainsContext)
        
        if #available(iOS 10.0, *) {
        } else {
            self.addObserver(self, forKeyPath: "stillImageOutput.capturingStillImage", options: .new, context: &CapturingStillImageContext)
        }
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
        
        self.removeObserver(self, forKeyPath: "device1.lensPosition", context: &LensPositionContext)
        self.removeObserver(self, forKeyPath: "device1.exposureDuration", context: &ExposureDurationContext)
        self.removeObserver(self, forKeyPath: "device1.ISO", context: &ISOContext)
        self.removeObserver(self, forKeyPath: "device1.deviceWhiteBalanceGains", context: &DeviceWhiteBalanceGainsContext)
        
        if #available(iOS 10.0, *) {
        } else {
            self.removeObserver(self, forKeyPath: "stillImageOutput.capturingStillImage", context: &CapturingStillImageContext)
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let oldValue = change![.oldKey]
        let newValue = change![.newKey]
        
        guard let context = context else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: nil)
            return
        }
        switch context {
        case &LensPositionContext:
            if let value = newValue as? Float {
                let newLensPosition = value
                
                DispatchQueue.main.async {
                        self.focusPositionSlider.value = newLensPosition
                    
                    
                    self.focusPositionValue.text = String(format: "%.1f", Double(newLensPosition))
                }
            }
        case &ExposureDurationContext:
            // Map from duration to non-linear UI range 0-1
            
            if let value = newValue as? CMTime {
                let newDurationSeconds = CMTimeGetSeconds(value)
                let exposureMode = self.device1!.exposureMode
                
                let minDurationSeconds = max(CMTimeGetSeconds(self.device1!.activeFormat.minExposureDuration), kExposureMinimumDuration)
                let maxDurationSeconds = CMTimeGetSeconds(self.device1!.activeFormat.maxExposureDuration)
                // Map from duration to non-linear UI range 0-1
                let p = (newDurationSeconds - minDurationSeconds) / (maxDurationSeconds - minDurationSeconds) // Scale to 0-1
                DispatchQueue.main.async {
                        self.exposureDurationSlider.value = Float(pow(p, 1 / self.kExposureDurationPower)) // Apply inverse power
                    
                    if newDurationSeconds < 1 {
                        let digits = max(0, 2 + Int(floor(log10(newDurationSeconds))))
                        self.exposureDurationValue.text = String(format: "1/%.*f", digits, 1/newDurationSeconds)
                    } else {
                        self.exposureDurationValue.text = String(format: "%.2f", newDurationSeconds)
                    }
                }
            }
        case &ISOContext:
            if let value = newValue as? Float {
                let newISO = value
                
                DispatchQueue.main.async {
                        self.exposureISOSlider.value = newISO
                    
                    self.exposureISOValue.text = String(Int(newISO))
                }
            }
        case &DeviceWhiteBalanceGainsContext:
            if let value = newValue as? NSValue {
                var newGains = AVCaptureWhiteBalanceGains()
                value.getValue(&newGains)
                
                let newTemperatureAndTint = self.device1!.temperatureAndTintValues(forDeviceWhiteBalanceGains: newGains)
                
                DispatchQueue.main.async {
                        self.whitebalanceTemperatureSlider.value = newTemperatureAndTint.temperature
                        self.whitebalanceTintSlider.value = newTemperatureAndTint.tint
                    
                    
                    self.temperatureValue.text = String(Int(newTemperatureAndTint.temperature))
                    self.tintValue.text = String(Int(newTemperatureAndTint.tint))
                }
            }
        case &ExposureTargetBiasContext:
            if let value = newValue as? Float {
                let newExposureTargetBias = value
                DispatchQueue.main.async {
                    //self.exposureTargetBiasValueLabel.text = String(format: "%.1f", Double(newExposureTargetBias))
                }
            }
        case &ExposureTargetOffsetContext:
            if let value = newValue as? Float {
                let newExposureTargetOffset = value
                DispatchQueue.main.async {
                    self.offsetSlider.value = newExposureTargetOffset
                    //self.exposureTargetOffsetValueLabel.text = String(format: "%.1f", Double(newExposureTargetOffset))
                }
            }

        case &CapturingStillImageContext:
            if #available(iOS 10.0, *) {
            } else {
                var isCapturingStillImage = false
                if let value = newValue as? Bool {
                    isCapturingStillImage = value
                }
                
                if isCapturingStillImage {
                    DispatchQueue.main.async {
                        self.previewView1.layer.opacity = 0.0
                        UIView.animate(withDuration: 0.25, animations: {
                            self.previewView1.layer.opacity = 1.0
                        })
                    }
                }
            }
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showpicture" {
        //var capturedImage1 = UIImage()

        let destination = segue.destination as! capturedPhotoViewController
        destination.capturedImage1 = self.image
        destination.capturedImage2 = self.image2
        print("prepare done for image1 and image2")
        // returns nil propertyfrom here
        //destination.navigationController!.setNavigationBarHidden(true, animated: false)
        }
    }

    @IBAction func viewCapturedPhotos(_ sender: Any) {
        performSegue(withIdentifier: "viewCapturedPhotos", sender: self)
    }
}

