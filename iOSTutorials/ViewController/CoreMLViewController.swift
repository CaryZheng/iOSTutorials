//
//  CoreMLViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/4/28.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit
import CoreML
import Vision

class CoreMLViewController: ZViewController {
    
    private var imageView: UIImageView!
    private var correctedImageView: UIImageView!
    private var classificationLabel: UILabel!
    
    private var inputImage: CIImage!
    
    private var startCameraBtn: UIButton!
    private var startChooseImageBtn: UIButton!
    
    lazy var rectanglesRequest: VNDetectRectanglesRequest = {
        return VNDetectRectanglesRequest(completionHandler: self.handleRectangles)
    }()
    
    lazy var classificationRequest: VNCoreMLRequest = {
        // Load the ML model through its generated class and create a Vision request for it.
        do {
            let model = try VNCoreMLModel(for: MNISTClassifier().model)
            return VNCoreMLRequest(model: model, completionHandler: self.handleClassification)
        } catch {
            fatalError("can't load Vision ML model: \(error)")
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 80, width: self.view.bounds.width, height: 200)
        imageView.backgroundColor = UIColor.red
        
        self.view.addSubview(imageView)
        
        correctedImageView = UIImageView()
        correctedImageView.frame = CGRect(x: 0, y: imageView.frame.origin.y+imageView.frame.height+20, width: self.view.bounds.width, height: 200)
        correctedImageView.backgroundColor = UIColor.blue
        
        self.view.addSubview(correctedImageView)
        
        classificationLabel = UILabel()
        classificationLabel.frame.origin.x = 0
        classificationLabel.frame.origin.y = correctedImageView.frame.origin.y + correctedImageView.frame.height + 20
        classificationLabel.frame = CGRect(x: 0, y: correctedImageView.frame.origin.y + correctedImageView.frame.height + 20, width: self.view.bounds.width, height: 20)
        classificationLabel.text = "Test"
        classificationLabel.textColor = UIColor.black
        
        self.view.addSubview(classificationLabel)
        
        startCameraBtn = UIButton()
        startCameraBtn.frame.origin.x = 0
        startCameraBtn.frame.origin.y = classificationLabel.frame.origin.y + classificationLabel.frame.height + 20
        startCameraBtn.setTitle("Camera", for: .normal)
        startCameraBtn.setTitleColor(UIColor.black, for: .normal)
        startCameraBtn.backgroundColor = UIColor.gray
        startCameraBtn.sizeToFit()
        
        self.view.addSubview(startCameraBtn)
        
        startCameraBtn.addTarget(self, action: #selector(onCameraBtnClicked(_:)), for: .touchUpInside)
        
        startChooseImageBtn = UIButton()
        startChooseImageBtn.frame.origin.x = 0
        startChooseImageBtn.frame.origin.y = startCameraBtn.frame.origin.y + startCameraBtn.frame.height + 20
        startChooseImageBtn.setTitle("Choose Image", for: .normal)
        startChooseImageBtn.setTitleColor(UIColor.black, for: .normal)
        startChooseImageBtn.backgroundColor = UIColor.gray
        startChooseImageBtn.sizeToFit()
        
        self.view.addSubview(startChooseImageBtn)
        
        startChooseImageBtn.addTarget(self, action: #selector(onChooseImageBtnClicked(_:)), for: .touchUpInside)
    }
    
    @objc func onCameraBtnClicked(_ sender: Any) {
        takePicture()
    }
    
    @objc func onChooseImageBtnClicked(_ sender: Any) {
        chooseImage()
    }
    
    private func chooseImage() {
        // The photo library is the default source, editing not allowed
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    private func takePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        present(picker, animated: true)
    }
    
    func handleRectangles(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNRectangleObservation]
            else { fatalError("unexpected result type from VNDetectRectanglesRequest") }
        guard let detectedRectangle = observations.first else {
            DispatchQueue.main.async {
                self.classificationLabel.text = "No rectangles detected."
            }
            return
        }
        let imageSize = inputImage.extent.size
        
        // Verify detected rectangle is valid.
        let boundingBox = detectedRectangle.boundingBox.scaled(to: imageSize)
        guard inputImage.extent.contains(boundingBox)
            else { print("invalid detected rectangle"); return }
        
        // Rectify the detected image and reduce it to inverted grayscale for applying model.
        let topLeft = detectedRectangle.topLeft.scaled(to: imageSize)
        let topRight = detectedRectangle.topRight.scaled(to: imageSize)
        let bottomLeft = detectedRectangle.bottomLeft.scaled(to: imageSize)
        let bottomRight = detectedRectangle.bottomRight.scaled(to: imageSize)
        let correctedImage = inputImage
            .cropped(to: boundingBox)
            .applyingFilter("CIPerspectiveCorrection", parameters: [
                "inputTopLeft": CIVector(cgPoint: topLeft),
                "inputTopRight": CIVector(cgPoint: topRight),
                "inputBottomLeft": CIVector(cgPoint: bottomLeft),
                "inputBottomRight": CIVector(cgPoint: bottomRight)
                ])
            .applyingFilter("CIColorControls", parameters: [
                kCIInputSaturationKey: 0,
                kCIInputContrastKey: 32
                ])
            .applyingFilter("CIColorInvert", parameters: [:])
        
        // Show the pre-processed image
        DispatchQueue.main.async {
            self.correctedImageView.image = UIImage(ciImage: correctedImage)
        }
        
        // Run the Core ML MNIST classifier -- results in handleClassification method
        let handler = VNImageRequestHandler(ciImage: correctedImage)
        do {
            try handler.perform([classificationRequest])
        } catch {
            print(error)
        }
    }
    
    func handleClassification(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNClassificationObservation]
            else { fatalError("unexpected result type from VNCoreMLRequest") }
        guard let best = observations.first
            else { fatalError("can't get best result") }
        
        DispatchQueue.main.async {
            self.classificationLabel.text = "Classification: \"\(best.identifier)\" Confidence: \(best.confidence)"
        }
    }
    
}

extension CoreMLViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        
        classificationLabel.text = "Analyzing Image…"
        correctedImageView.image = nil
        
        guard let uiImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { fatalError("no image from image picker") }
        guard let ciImage = CIImage(image: uiImage) else { fatalError("can't create CIImage from UIImage") }
        
        let orientation = CGImagePropertyOrientation(uiImage.imageOrientation)
        
        inputImage = ciImage.oriented(forExifOrientation: Int32(orientation.rawValue))
        
        imageView.image = uiImage
        
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([self.rectanglesRequest])
            } catch {
                print(error)
            }
        }
    }
    
}
