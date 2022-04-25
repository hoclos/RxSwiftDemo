//
// Created on 2022/4/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private let accountTextField = UITextField()
    private let passwordTextField = UITextField()
    private let verifyPasswordTextField = UITextField()
    private let registerButton = UIButton(type: .system)
}

private extension ViewController {
    func setupUI() {
        configureAccountTextField()
        configurePasswordTextField()
        configureVerifyPasswordTextField()
        configureRegisterButton()
    }
    
    func configureAccountTextField() {
        accountTextField.placeholder = "account"
        accountTextField.layer.borderWidth = 1
        accountTextField.layer.borderColor = UIColor.systemGray.cgColor
        accountTextField.layer.cornerRadius = 6
        view.addSubview(accountTextField)
        
        accountTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.height.equalTo(36)
            $0.leading.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
        }
    }
    
    func configurePasswordTextField() {
        passwordTextField.placeholder = "password"
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.systemGray.cgColor
        passwordTextField.layer.cornerRadius = 6
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(accountTextField.snp.bottom).offset(20)
            $0.width.height.centerX.equalTo(accountTextField)
        }
    }
    
    func configureVerifyPasswordTextField() {
        verifyPasswordTextField.placeholder = "verify password"
        verifyPasswordTextField.layer.borderWidth = 1
        verifyPasswordTextField.layer.borderColor = UIColor.systemGray.cgColor
        verifyPasswordTextField.layer.cornerRadius = 6
        view.addSubview(verifyPasswordTextField)
        
        verifyPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.width.height.centerX.equalTo(accountTextField)
        }
    }
    
    func configureRegisterButton() {
        registerButton.setTitle("register", for: .normal)
        view.addSubview(registerButton)
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(verifyPasswordTextField.snp.bottom).offset(20)
            $0.height.equalTo(44)
            $0.leading.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
        }
    }
}
