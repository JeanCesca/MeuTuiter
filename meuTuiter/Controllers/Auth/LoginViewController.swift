//
//  LoginViewController.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "twittercolor")
        
        view.addSubview(logoImageView)
        view.addSubview(emailLogoImage)
        view.addSubview(emailTextField)
        view.addSubview(thinView)
        view.addSubview(passwordLogoImage)
        view.addSubview(passwordTextField)
        view.addSubview(thinViewPassword)
        view.addSubview(loginButton)
        view.addSubview(attributedButton)
        
        configureConstraints()
        
        actions()
    }
    
    private func actions() {
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        attributedButton.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { results, error in
            if let error = error {
                print("DEBUG: Error logging in: \(error.localizedDescription)")
                return
            }
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            guard let tab = window.rootViewController as? MainTabController? else { return }
            tab?.authenticateUser()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func showSignUp() {
        let regController = RegistrationViewController()
        regController.modalPresentationStyle = .overFullScreen
        present(regController, animated: true, completion: nil)
    }
    
    
    private let logoImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "TwitterLogo")
        return imageView
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
        password.autocapitalizationType = .none
        
        return password
    }()
    
    private let thinViewPassword: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .white
        button.setTitleColor(UIColor(named: "twittercolor"), for: .normal)
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let attributedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Don't have an account? Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = UIColor(named: "twittercolor")
        button.layer.cornerRadius = 8

        return button
    }()
    
    private func configureConstraints() {
        
        let logoImageViewConstraints = [
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150)
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
        
        let loginButtonConstraints = [
            loginButton.leadingAnchor.constraint(equalTo: thinViewPassword.leadingAnchor),
            loginButton.topAnchor.constraint(equalTo: thinViewPassword.bottomAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: thinViewPassword.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let attributedButtonConstraints = [
            attributedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            attributedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            attributedButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            attributedButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            attributedButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(logoImageViewConstraints)
        NSLayoutConstraint.activate(emailLogoImageConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(thinViewConstraints)
        NSLayoutConstraint.activate(passwordLogoImageConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(thinViewPasswordConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
        NSLayoutConstraint.activate(attributedButtonConstraints)

    }
}

