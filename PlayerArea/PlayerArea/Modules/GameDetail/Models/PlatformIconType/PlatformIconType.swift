//
//  PlatformIconType.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 16.12.2022.
//

import UIKit

enum PlatformIconType: String, Codable {
    case pc = "pc"
    case ps2 = "playstation2"
    case ps3 = "playstation3"
    case ps4 = "playstation4"
    case ps5 = "playstation5"
    case xbox360 = "xbox360"
    case xboxSX = "xbox-series-x"
    case xboxOne = "xbox-one"
    case nintendoSwitch = "nintendo-switch"
    case nintendo3ds = "nintendo-3ds"
    case linux = "linux"
    case macos = "macos"
    case android = "android"
    case psVita = "ps-vita"
    case ios = "ios"
    case xboxOld = "xbox-old"
    case web = "web"
    case wiiU = "wii-u"
    
    var icon: UIImage {
        switch self {
        case .pc:
            return .pc
        case .macos:
            return .macos
        case .ps2, .ps3, .ps4, .ps5, .psVita:
            return .ps
        case .xbox360, .xboxSX, .xboxOne, .xboxOld:
            return .xbox
        case .nintendoSwitch, .nintendo3ds:
            return .nintendo
        case .linux:
            return .linux
        case .android:
            return .android
        case .ios:
            return .ios
        case .web:
            return .web
        case .wiiU:
            return .wiiU
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .pc:
            return .white
        case .macos:
            return .black
        case .ps2, .ps3, .ps4, .ps5:
            return .white
        case .xbox360, .xboxSX, .xboxOne, .xboxOld:
            return .white
        case .nintendoSwitch, .nintendo3ds:
            return .white
        case .linux:
            return .white
        case .android:
            return .white
        case .psVita:
            return .white
        case .ios:
            return .white
        case .web:
            return .white
        case .wiiU:
            return .white
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .pc:
            return .black
        case .macos:
            return .white
        case .ps2, .ps3, .ps4, .ps5:
            return .systemBlue
        case .xbox360, .xboxSX, .xboxOne, .xboxOld:
            return .systemGreen
        case .nintendoSwitch, .nintendo3ds:
            return .systemRed
        case .linux:
            return .systemOrange
        case .android:
            return .systemGreen
        case .psVita:
            return .gray
        case .ios:
            return .systemYellow
        case .web:
            return .systemCyan
        case .wiiU:
            return .systemGray5
        }
    }
}
