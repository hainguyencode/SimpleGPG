//
//  ConvertUtil.swift
//  autoSDKEngine
//
//  Created by Nguyen Thanh Hai on 6/1/17.
//  Copyright © 2017 fossil. All rights reserved.
//

import Foundation


public func dict2JsonString(dict: Dictionary<AnyHashable, Any>) -> String {
    if dict.isEmpty {
        return "empty"
    }
    var jsonData: Data? = nil
    do {
        try jsonData = JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    } catch let error as NSError {
//        Logger.logger.debug("dict2JsonString: \(error.localizedDescription)")
        return "error"
    }
    if jsonData == nil {
        return "nil"
    }
    return NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)! as String
}

public func jsonString2Dict(jsonString: String) -> Dictionary<String, Any>? {
    let json = jsonString.data(using: .utf8)
    var dict: Dictionary<String, Any>? = Dictionary<String, Any>()
    if json != nil {
        do {
            try dict = JSONSerialization.jsonObject(with: json!, options: []) as? [String: Any]
        }
        catch _ as NSError {
            return nil
        }
        return dict
    }
    return nil
}

public func dataWithHexString(hex: String) -> Data {
//    var hex = hex
//    var data = Data()
//    while(hex.characters.count > 0) {
//        let c: String = hex.substring(to: hex.index(hex.startIndex, offsetBy: 2))
//        hex = hex.substring(from: hex.index(hex.startIndex, offsetBy: 2))
//        var ch: UInt32 = 0
//        Scanner(string: c).scanHexInt32(&ch)
//        var char = UInt8(ch)
//        Logger.logger.debug("data from hex: \(char)")
//        data.append(&char, count: 1)
//    }
//    
//    return data
    
//    var result = UInt32(strtoul(hex, nil, 16))
//    let data = Data(bytes: &result, count: MemoryLayout<UInt32>.size)
//    
//    return data
//    let uint8Array = hex.hexa2Bytes
//    
//    for aUint8 in uint8Array {
//        aUint8.
//    }
    let data = Data.init(bytes: hex.hexa2Bytes)
    
//    for ele in data {
//        Logger.logger.debug("aElement: \(ele)")
//    }
    
    return data
}

extension String {
    var drop0xPrefix:          String { return hasPrefix("0x") ? String(characters.dropFirst(2)) : self }
    var drop0bPrefix:          String { return hasPrefix("0b") ? String(characters.dropFirst(2)) : self }
    var hexaToDecimal:            Int { return Int(drop0xPrefix, radix: 16) ?? 0 }
    var hexaToBinaryString:    String { return String(hexaToDecimal, radix: 2) }
    var decimalToHexaString:   String { return String(Int(self) ?? 0, radix: 16) }
    var decimalToBinaryString: String { return String(Int(self) ?? 0, radix: 2) }
    var binaryToDecimal:          Int { return Int(drop0bPrefix, radix: 2) ?? 0 }
    var binaryToHexaString:    String { return String(binaryToDecimal, radix: 16) }
    var hexa2Bytes: [UInt8] {
        let hexa = Array(characters)
        return stride(from: 0, to: characters.count, by: 2).flatMap { UInt8(String(hexa[$0..<$0.advanced(by: 2)]), radix: 16) }
    }
}

extension Int {
    var toBinaryString: String { return String(self, radix: 2) }
    var toHexaString:   String { return String(self, radix: 16) }
}

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
