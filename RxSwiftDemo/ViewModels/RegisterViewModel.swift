//
// Created on 2022/4/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol RegisterViewModelInput {
    /// 帳號
    var accountString: BehaviorRelay<String?> { get }
    /// 密碼
    var passwordString: BehaviorRelay<String?> { get }
    /// 驗證密碼
    var verifyPasswordString: BehaviorRelay<String?> { get }
    /// 送出註冊
    func register()
}

protocol RegisterViewModelOutput {
    /// 註冊結果
    var registerResult: PublishRelay<RegisterViewModel.RegisterResult> { get }
}

protocol RegisterViewModelPrototype {
    var input: RegisterViewModelInput { get }
    var output: RegisterViewModelOutput { get }
}

class RegisterViewModel: RegisterViewModelPrototype, RegisterViewModelOutput {
    /// 註冊結果
    enum RegisterResult {
        case successful
        case failed
    }
    
    var input: RegisterViewModelInput { self }
    var output: RegisterViewModelOutput { self }
    
    let registerResult = PublishRelay<RegisterResult>()
    let accountString = BehaviorRelay<String?>(value: nil)
    let passwordString = BehaviorRelay<String?>(value: nil)
    let verifyPasswordString = BehaviorRelay<String?>(value: nil)
    
    private let disposeBag = DisposeBag()
}

extension RegisterViewModel: RegisterViewModelInput {
    func register() {
        guard let accountString = accountString.value, accountString.count >= 6,
              let passwordString = passwordString.value, passwordString.count >= 8,
              let verifyPasswordString = verifyPasswordString.value,
              passwordString == verifyPasswordString  else {
                  registerResult.accept(.failed)
                  
                  return
              }
        
        registerResult.accept(.successful)
    }
}
