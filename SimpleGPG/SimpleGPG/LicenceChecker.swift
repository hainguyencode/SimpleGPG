//
//  LicenceChecker.swift
//  SimpleGPG
//
//  Created by Nguyen Thanh Hai on 8/28/17.
//  Copyright © 2017 fossil. All rights reserved.
//

import Foundation
import ObjectivePGP

let PublicKeyName: String = "9D5FE6EE"//"329ED42C"//"A4FFEDBE" // "D035FBF2"
let PrivateKeyName: String = "44E79D1B"

class LicenceChecker {
    public static let instance: LicenceChecker = LicenceChecker()
    private let pgp: ObjectivePGP = ObjectivePGP()
    
    private init() {
        pgp.importKeys(fromFile: Bundle.main.path(forResource: "PublicKey", ofType: "asc")!)
//        pgp.importKeys(fromFile: Bundle.main.path(forResource: PrivateKeyName, ofType: "asc")!) // 4C32E6A2
        for key in pgp.keys {
            print("key : \(key.keyID.debugDescription)")
        }
        if self.pgp.findKey(forIdentifier: PublicKeyName) == nil {
            print("key not found")
        } else {
            print("founded public key")
        }
        
        if self.pgp.findKey(forIdentifier: PrivateKeyName) == nil {
            print("key not found")
        } else {
            print("founded private key")
        }
        
    }
    
    private func verifyLicense(signedData: Data) -> Bool {
        
        do {
            let contentFile = URL(fileURLWithPath: Bundle.main.path(forResource: "license", ofType: nil)!)
            let test = try String(contentsOf: contentFile)
            print("test : \(test)")
            let data = test.data(using: .utf8)!
            let key = self.pgp.findKey(forIdentifier: PublicKeyName)!
//            print("begin build signature for data : \(data)")
//            let signature = try self.pgp.sign(data, using: key, passphrase: nil, detached: true)
//            print("begin verify")
            try self.pgp.verifyData(data, withSignature: signedData)
            print("\n\n\n\n\nverify is success")
            return true
            
        } catch (let error) {
            print("error happended : \(error.localizedDescription)")
        }
        
        return false
    }
    
    public func readLicense(signedData: Data) -> Bool {
        print("read license begin")
        return self.verifyLicense(signedData: signedData)
//        return self.decrypt(encryptedData:signedData)
    }
    
    public func sign(data: Data) -> Data? {
        let signedData: Data
        
        do {
            let key = self.pgp.findKey(forIdentifier: PrivateKeyName)!
            print("founded private key")
            signedData = try self.pgp.sign(data, using: key, passphrase: nil, detached: true)
        
            print("signed data : \n\n\n\n\n\n  \(String(data: signedData, encoding: .ascii)?.utf8CString)   \n\n\n\n\n\n")
        } catch (let error) {
            print("sign error : \(error.localizedDescription)")
            return nil
        }
        return signedData
    }
    
    private func decrypt(encryptedData: Data) -> Bool {
        do {
            // import decrypt key
            pgp.importKeys(fromFile: Bundle.main.path(forResource: "44E79D1B", ofType: "asc")!) // 4C32E6A2
            let data = try pgp.decryptData(encryptedData, passphrase: nil)
            print("decrypt success : \(data.description)")
        } catch (let error) {
            print("decrypt error : \(error.localizedDescription)")
        }
        
        return false
    }
}
