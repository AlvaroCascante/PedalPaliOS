//
//  FirebaseUserInfoMapper.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//
import FirebaseAuth

struct FirebaseUserMapper {
    static func toDomain(_ user: User) -> FirebaseUserInfo {
        FirebaseUserInfo(
            uid: user.uid,
            email: user.email,
            displayName: user.displayName,
            isEmailVerified: user.isEmailVerified
        )
    }
}
