//
//  ProfileViewController.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    var imagePicker: ImagePicker!
    var profileHomeViewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    

    func setupView() {
        self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.frame.size.width/2
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    func setupData() {
        
        if let image = UserDefaults.standard.value(forKey: "profileImageUrl") as? String,
            let name = UserDefaults.standard.value(forKey: "userName") as? String {
            self.profileHomeViewModel.imageUrl = image
            self.userNameLabel.text = name
            userProfileImageView.sd_setImage(with: URL(string: self.profileHomeViewModel.imageUrl!),placeholderImage:#imageLiteral(resourceName: "userPlace.png"),options:[.continueInBackground])
        }
        
    }
    
    func updatePhoto() {
        Loader.shared.showActivityIndicator(viewToPresent: self)
        self.profileHomeViewModel.uploadImageData { result in
            Loader.shared.hideActivity()
         
            switch result {
                case true:
                    self.setupData()
                break
                
                case false:
                    print("Error al traer la url de la imagen")
                break
                
            }
        }
        
    }
    

    @IBAction func logOutPressed(_ sender: UIButton) {
      
        Animations.shared.animateButtonPulse(view: sender, scaleX: 0.9, y: 0.9, duration: 0.1, withImpact: true)
               
            Utils.shared.delayWithSeconds(0.2) {
            self.profileHomeViewModel.logOut { result in
                switch result {
                    case true:
                    Navigations.shared.showLogin(vCToPresent: self)
                    break
                    
                    case false:
                        print("Error al tratar de cerrar la sesion")
                    break
                    
                }
            }
        }
    }
    
    @IBAction func cemeraPressed(_ sender: UIButton) {
        
        Animations.shared.animateButtonPulse(view: sender, scaleX: 0.9, y: 0.9, duration: 0.1, withImpact: true)
               
        Utils.shared.delayWithSeconds(0.2) {
                   
            self.imagePicker.present(from: sender)
        }
    }
    
}

extension ProfileViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        if image != nil {
            self.profileHomeViewModel.image = image
            self.updatePhoto()
        }
    }
    
}
