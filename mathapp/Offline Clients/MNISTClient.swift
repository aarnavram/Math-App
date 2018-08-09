//
//  MNISTClient.swift
//  mathapp
//
//  Created by Aarnav Ram on 13/06/18.
//  Copyright © 2018 Aarnav Ram. All rights reserved.
//

import UIKit
import CoreML
import Vision

public class MNISTClient {
    public static let sharedInstance = MNISTClient()
    public static var digit : String?
    
    //method to send the request to predict the number
    public func predict(_ image: UIImage) {
        guard let model = try? VNCoreMLModel(for: MNIST().model) else { return }
        let request = VNCoreMLRequest(model: model, completionHandler: assignNumber)
        guard let ciImage = CIImage(image: image) else {return }
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            debugPrint(error)
        }
    }
    
    //method will assign the predicted digit
    public func assignNumber(request: VNRequest, error: Error?) {
        guard let results = request.results, let resultsArray = results as? [VNClassificationObservation] else {
            return }
        MNISTClient.digit = resultsArray[0].identifier
    }
}
