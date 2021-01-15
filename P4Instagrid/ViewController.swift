//
//  ViewController.swift
//  P4Instagrid
//
//  Created by Jeremy viviand on 08/01/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Instagrid
    @IBOutlet weak var labelInstagrid: UILabel!
    // bouton pour les photos
    @IBOutlet weak var ButtonPictureHautG: UIButton!
    @IBOutlet weak var buttonPictureHautD: UIButton!
    @IBOutlet weak var buttonPictureBasG: UIButton!
    @IBOutlet weak var buttonPictureBasD: UIButton!
    // bouton glisser pour partager le resultat
    @IBOutlet weak var imageViewArrowUp: UIImageView!
    @IBOutlet weak var imageViewArrowLeft: UIImageView!
    @IBOutlet weak var labelSwipe: UILabel!
    // bouton avec differente vue ou l'image valider s'affiche ou non
    @IBOutlet weak var firstBouton: UIButton!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var centerBouton: UIButton!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var lastBouton: UIButton!
    @IBOutlet weak var lastImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func firstHiddenBouton(_ sender: Any) {
        firstImageView.isHidden = false
        centerImageView.isHidden = true
        lastImageView.isHidden = true
        
        ButtonPictureHautG.isHidden = false
        buttonPictureHautD.isHidden = true
        buttonPictureBasG.isHidden = false
        buttonPictureBasD.isHidden = false

    }
    
    @IBAction func centerHiddenBouton(_ sender: Any) {
        firstImageView.isHidden = true
        centerImageView.isHidden = false
        lastImageView.isHidden = true
        
        ButtonPictureHautG.isHidden = false
        buttonPictureHautD.isHidden = false
        buttonPictureBasG.isHidden = false
        buttonPictureBasD.isHidden = true
        
    }
    @IBAction func lastHiddenBouton(_ sender: Any) {
        firstImageView.isHidden = true
        centerImageView.isHidden = true
        lastImageView.isHidden = false
        
        ButtonPictureHautG.isHidden = false
        buttonPictureHautD.isHidden = false
        buttonPictureBasG.isHidden = false
        buttonPictureBasD.isHidden = false
    }
    
    @IBAction func openPhotoLibraryButton(_ sender: Any) {
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
        
        dismiss(animated:true, completion: nil)
    }
}

