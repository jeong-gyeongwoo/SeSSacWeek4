//
//  UserDefaultsHelper.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/11.
//

import Foundation

//컴파일최적화 -> 이 자리에 쓰면 모든 파일에 적용

class UserDefaultsHelper { //PropertyWrapper로 더 효율적?
    //싱글턴 패턴, 초기화는 여기서만
    static let standard = UserDefaultsHelper()
    
    private init() { } //접근제어자(다음주) 외부에서 초기화 못하게
    
    let userDefaults = UserDefaults.standard
    
    
    
    //UserDefaults.standard.set("sadasd", forkey:"asd")
    
    enum Key: String { //컴파일최적화
        case nickname, age
    }

    var nickname: String {
        get{
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
             userDefaults.set(newValue, forKey: Key.nickname.rawValue)

        }
    }
    
    var age: Int {
        get{
            return userDefaults.integer(forKey: Key.age.rawValue)

        }
        set {
             userDefaults.set(newValue, forKey: Key.age.rawValue)

        }
    }
}
