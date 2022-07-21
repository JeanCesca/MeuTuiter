//
//  RegistrationViewController.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.backgroundColor = UIColor(named: "twittercolor")
        
        view.addSubview(userImageView)
        view.addSubview(emailLogoImage)
        view.addSubview(emailTextField)
        view.addSubview(thinView)
        
        view.addSubview(passwordLogoImage)
        view.addSubview(passwordTextField)
        view.addSubview(thinViewPassword)
        
        view.addSubview(fullNameLogoImage)
        view.addSubview(fullNameTextField)
        view.addSubview(thinViewFullName)
        
        view.addSubview(usernameLogoImage)
        view.addSubview(usernameTextField)
        view.addSubview(thinViewUsername)
        
        view.addSubview(signupButton)
        view.addSubview(attributedButton)
    
        configureConstraints()
        actions()
    }
    
    private func actions() {
        userImageView.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        attributedButton.addTarget(self, action: #selector(handleshowLogin), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(handleShowLRegistration), for: .touchUpInside)
        
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleshowLogin() {
        let loginController = LoginViewController()
        loginController.modalPresentationStyle = .overFullScreen
        present(loginController, animated: true, completion: nil)
    }
    
    @objc func handleShowLRegistration() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let profileImageURL = profileImage else { return }
        
        let authCredentials = AuthData(email: email, password: password, fullname: fullname, username: username, profileImageURL: profileImageURL)
        
        AuthService.shared.registerUser(credentials: authCredentials) { error, reference in
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            guard let tab = window.rootViewController as? MainTabController? else { return }
            tab?.authenticateUser()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private let userImageView: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let emailLogoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "envelope"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let email = UITextField()
        email.translatesAutoresizingMaskIntoConstraints = false
        email.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        email.textColor = .white
        email.font = .systemFont(ofSize: 16, weight: .light)
        email.keyboardType = .emailAddress
        email.textContentType = .username
        email.clipsToBounds = true
        email.layer.cornerRadius = 10
        email.autocapitalizationType = .none
        
        return email
    }()
    
    private let thinView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    private let passwordLogoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "lock.circle"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let passwordTextField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.textColor = .white
        password.font = .systemFont(ofSize: 16, weight: .light)
        password.isSecureTextEntry = true
        password.textContentType = .password
        password.clipsToBounds = true
        password.layer.cornerRadius = 10
        
        return password
    }()
    
    private let thinViewPassword: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    private let fullNameLogoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let fullNameTextField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.textColor = .white
        password.font = .systemFont(ofSize: 16, weight: .light)
        password.clipsToBounds = true
        password.layer.cornerRadius = 10
        
        return password
    }()
    
    private let thinViewFullName: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    private let usernameLogoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameTextField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.textColor = .white
        password.font = .systemFont(ofSize: 16, weight: .light)
        password.clipsToBounds = true
        password.layer.cornerRadius = 10
        
        return password
    }()
    
    private let thinViewUsername: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .white
        button.setTitleColor(UIColor(named: "twittercolor"), for: .normal)
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let attributedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Already have an account? Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = UIColor(red: 26/255, green: 140/255, blue: 230/255, alpha: 1)
        button.layer.cornerRadius = 8

        return button
    }()
    
    private func configureConstraints() {
        
        let userImageViewConstraints = [
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            userImageView.widthAnchor.constraint(equalToConstant: 150),
            userImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let emailLogoImageConstraints = [
            emailLogoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailLogoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 250)
        ]
        
        let emailTextFieldConstraints = [
            emailTextField.leadingAnchor.constraint(equalTo: emailLogoImage.trailingAnchor, constant: 10),
            emailTextField.centerYAnchor.constraint(equalTo: emailLogoImage.centerYAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        let thinViewConstraints = [
            thinView.leadingAnchor.constraint(equalTo: emailLogoImage.leadingAnchor),
            thinView.topAnchor.constraint(equalTo: emailLogoImage.bottomAnchor, constant: 6),
            thinView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            thinView.heightAnchor.constraint(equalToConstant: 1),
        ]
        
        let passwordLogoImageConstraints = [
            passwordLogoImage.leadingAnchor.constraint(equalTo: emailLogoImage.leadingAnchor),
            passwordLogoImage.topAnchor.constraint(equalTo: emailLogoImage.bottomAnchor, constant: 40)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLogoImage.trailingAnchor, constant: 10),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordLogoImage.centerYAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        let thinViewPasswordConstraints = [
            thinViewPassword.leadingAnchor.constraint(equalTo: passwordLogoImage.leadingAnchor),
            thinViewPassword.topAnchor.constraint(equalTo: passwordLogoImage.bottomAnchor, constant: 6),
            thinViewPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            thinViewPassword.heightAnchor.constraint(equalToConstant: 1),
        ]
        
        let fullNameLogoImageConstraints = [
            fullNameLogoImage.leadingAnchor.constraint(equalTo: emailLogoImage.leadingAnchor),
            fullNameLogoImage.topAnchor.constraint(equalTo: passwordLogoImage.bottomAnchor, constant: 40)
        ]
        
        let fullNameTextFieldConstraints = [
            fullNameTextField.leadingAnchor.constraint(equalTo: fullNameLogoImage.trailingAnchor, constant: 10),
            fullNameTextField.centerYAnchor.constraint(equalTo: fullNameLogoImage.centerYAnchor),
            fullNameTextField.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        let thinViewFullNameConstraints = [
            thinViewFullName.leadingAnchor.constraint(equalTo: fullNameLogoImage.leadingAnchor),
            thinViewFullName.topAnchor.constraint(equalTo: fullNameLogoImage.bottomAnchor, constant: 6),
            thinViewFullName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            thinViewFullName.heightAnchor.constraint(equalToConstant: 1),
        ]
        
        let usernameLogoImageConstraints = [
            usernameLogoImage.leadingAnchor.constraint(equalTo: emailLogoImage.leadingAnchor),
            usernameLogoImage.topAnchor.constraint(equalTo: fullNameLogoImage.bottomAnchor, constant: 40)
        ]
        
        let usernameTextFieldConstraints = [
            usernameTextField.leadingAnchor.constraint(equalTo: usernameLogoImage.trailingAnchor, constant: 10),
            usernameTextField.centerYAnchor.constraint(equalTo: usernameLogoImage.centerYAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        let usernameViewConstraints = [
            thinViewUsername.leadingAnchor.constraint(equalTo: fullNameLogoImage.leadingAnchor),
            thinViewUsername.topAnchor.constraint(equalTo: usernameLogoImage.bottomAnchor, constant: 6),
            thinViewUsername.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            thinViewUsername.heightAnchor.constraint(equalToConstant: 1),
        ]
        
        let signupButtonConstraints = [
            signupButton.leadingAnchor.constraint(equalTo: thinViewUsername.leadingAnchor),
            signupButton.topAnchor.constraint(equalTo: thinViewUsername.bottomAnchor, constant: 20),
            signupButton.trailingAnchor.constraint(equalTo: thinViewUsername.trailingAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let attributedButtonConstraints = [
            attributedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            attributedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            attributedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            attributedButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(userImageViewConstraints)
        
        NSLayoutConstraint.activate(emailLogoImageConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(thinViewConstraints)
        
        NSLayoutConstraint.activate(passwordLogoImageConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(thinViewPasswordConstraints)
        
        NSLayoutConstraint.activate(fullNameLogoImageConstraints)
        NSLayoutConstraint.activate(fullNameTextFieldConstraints)
        NSLayoutConstraint.activate(thinViewFullNameConstraints)
        
        NSLayoutConstraint.activate(usernameLogoImageConstraints)
        NSLayoutConstraint.activate(usernameTextFieldConstraints)
        NSLayoutConstraint.activate(usernameViewConstraints)
        
        NSLayoutConstraint.activate(signupButtonConstraints)
        
        NSLayoutConstraint.activate(attributedButtonConstraints)
    }

}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.userImageView.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.profileImage = profileImage
        
        userImageView.layer.cornerRadius = 150/2
        userImageView.layer.masksToBounds = true
        userImageView.imageView?.contentMode = .scaleAspectFill
        userImageView.imageView?.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
    
}

