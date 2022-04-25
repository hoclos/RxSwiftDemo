//
// Created on 2022/4/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RegisterViewModel()
        
        setupUI()
        
        guard let viewModel = viewModel else { return }
        
        bind(viewModel)
    }
    
    private var viewModel: RegisterViewModelPrototype?
    
    private let accountTextField = UITextField()
    private let passwordTextField = UITextField()
    private let verifyPasswordTextField = UITextField()
    private let registerButton = UIButton(type: .system)
    
    private let disposeBag = DisposeBag()
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

private extension ViewController {
    func bind(_ viewModel: RegisterViewModelPrototype) {
        viewModel
            .registerResult
            .subscribe(onNext: { [weak self] result in
                var message: String {
                    switch result {
                    case .successful:
                        return "Register successful"
                    case .failed:
                        return "Register failed"
                    }
                }
                
                let cancelAction: UIAlertAction = .init(title: "OK", style: .cancel)
                let alert: UIAlertController = .init(title: "System Alert",
                                                     message: message,
                                                     preferredStyle: .alert)
                alert.addAction(cancelAction)
                
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        accountTextField
            .rx
            .text
            .subscribe(onNext: { text in
                viewModel.accountString.accept(text)
            })
            .disposed(by: disposeBag)
        
        passwordTextField
            .rx
            .text
            .subscribe(onNext: { text in
                viewModel.passwordString.accept(text)
            })
            .disposed(by: disposeBag)
        
        verifyPasswordTextField
            .rx
            .text
            .subscribe(onNext: { text in
                viewModel.verifyPasswordString.accept(text)
            })
            .disposed(by: disposeBag)
        
        registerButton
            .rx
            .tap
            .subscribe(onNext: { _ in
                viewModel.register()
            })
            .disposed(by: disposeBag)
    }
}
