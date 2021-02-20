//
//  ViewController.swift
//  P4Instagrid
//
//  Created by Jeremy viviand on 08/01/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // view
    @IBOutlet weak var viewBlue: UIView!
    // Swipe Label
    @IBOutlet weak var swipeLabel: UILabel!
    // bouton pour les photos
    @IBOutlet weak var buttonPictureFirstHigh: UIButton!
    @IBOutlet weak var buttonPictureLastHigh: UIButton!
    @IBOutlet weak var buttonPictureFirstLow: UIButton!
    @IBOutlet weak var buttonPictureLastLow: UIButton!
    // bouton avec differente vue ou l'image valider s'affiche ou non
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var lastButton: UIButton!
    @IBOutlet weak var lastImageView: UIImageView!
    
    
    
    private var buttonImage: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeLabel(bool: UIApplication.shared.statusBarOrientation.isPortrait)
        addGestureRecognizer()
        buttonForView(firstButton)
    }
    
    // fonction pour changer le label Swipe
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        swipeLabel(bool: UIDevice.current.orientation.isPortrait)
    }
    
    private func swipeLabel(bool: Bool) {
        swipeLabel.text = (bool) ? "Swipe up to share" : "Swipe left to share"
    }
    
    // fonction pour addgesturerecognizer
    
    private func addGestureRecognizer() {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(directionSwipes(_:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(directionSwipes(_:)))
        upSwipe.direction = .up
        leftSwipe.direction = .left
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(leftSwipe)
    }
    
    //action pour permettre de selectionner la vue que l'on souhaite
    
    @IBAction func buttonForView(_ sender: UIButton) {
        switch sender {
        case firstButton:
            firstImageView.isHidden = false
            centerImageView.isHidden = true
            lastImageView.isHidden = true
            
            buttonPictureFirstHigh.isHidden = false
            buttonPictureLastHigh.isHidden = true
            buttonPictureFirstLow.isHidden = false
            buttonPictureLastLow.isHidden = false
        case centerButton:
            firstImageView.isHidden = true
            centerImageView.isHidden = false
            lastImageView.isHidden = true
            
            buttonPictureFirstHigh.isHidden = false
            buttonPictureLastHigh.isHidden = false
            buttonPictureFirstLow.isHidden = false
            buttonPictureLastLow.isHidden = true
        case lastButton:
            firstImageView.isHidden = true
            centerImageView.isHidden = true
            lastImageView.isHidden = false
            
            buttonPictureFirstHigh.isHidden = false
            buttonPictureLastHigh.isHidden = false
            buttonPictureFirstLow.isHidden = false
            buttonPictureLastLow.isHidden = false
        default:
            break
        }
    }
    
    // Action pour selectionner une image dans notre librairie
    
    @IBAction func buttonPhotoLibrary(_ sender: UIButton) {
        buttonImage = sender
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let Picker = UIImagePickerController()
            Picker.delegate = self
            Picker.sourceType = .photoLibrary;
            Picker.allowsEditing = true
            present(Picker, animated: true, completion: nil)
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.buttonImage?.setImage(image, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    
    // animation pour le swipe
    
    @objc func directionSwipes(_ sender:UISwipeGestureRecognizer) {
        if UIDevice.current.orientation.isLandscape {
            print("left")
            self.animationY(value: -UIScreen.main.bounds.height)
        } else {
            print("up")
            self.animationX(with: -UIScreen.main.bounds.width)
        }
    }
    private func animationX(with value: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseOut]) {
            self.viewBlue.transform = CGAffineTransform(translationX: 0, y: value)
        } completion: { (success) in
            self.createPicture()
        }
    }
    private func animationY(value: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseOut]) {
            self.viewBlue.transform = CGAffineTransform(translationX: value, y: 0)
        } completion: { (success) in
            self.createPicture()
        }
    }
    // share
    func createPicture() {
        let renderer = UIGraphicsImageRenderer(size: viewBlue.bounds.size)
        let capturedImage = renderer.image {
            (ctx) in
            viewBlue.drawHierarchy(in: viewBlue.bounds, afterScreenUpdates: true)
        }
        let activityController = UIActivityViewController (activityItems: [capturedImage], applicationActivities: nil)
        present(activityController, animated: true)
        activityController.completionWithItemsHandler = { _ , _ , _, _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.viewBlue.transform = .identity
            })
        }
    }
}
