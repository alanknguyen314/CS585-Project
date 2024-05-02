private func recognizeText(image: UIImage?) {
    guard let cgImage = image?.cgImage else {
        print("error could not cgimage")
        return
    }
    //Handler
    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    //Request
    let request = VNRecognizeTextRequest { [weak self] request, error in
        guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else{
            return
        }
        let text = observations.compactMap({
            $0.topCandidates(1).first?.string
        }).joined(separator: ", ")
        
        DispatchQueue.main.async {
            self?.label.text  = text
        }
    }
    //Process Request
    do{
        try handler.perform([request])
    }catch{
        print(error.localizedDescription)
    }
}
