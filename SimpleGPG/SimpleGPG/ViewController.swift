//
//  ViewController.swift
//  SimpleGPG
//
//  Created by Nguyen Thanh Hai on 8/28/17.
//  Copyright © 2017 fossil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var licenseChecker: LicenceChecker? = nil
    
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var signBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.licenseChecker = LicenceChecker.instance
    }

    override func viewDidAppear(_ animated: Bool) {
//        let content: Data = Data(base64Encoded: "test")!
//        let data: Data = Data(base64Encoded: "iQIcBAABCgAGBQJZo+qVAAoJEB35yCnljPqu0IAQAJy+cIml3jd5ujHKhMwmNFgmxmsBuMJZjEyK/iPnvRoNUPng5u842JV66BDHtYpY09HojU+QNe8TYJj801mlDiK5Un4tHmm4rdTd+amOYB28rjJJX4gYXHotbELDgxAYAd4iROw8PwO3SuYT2ZED4Qogj+9BI9MoJYz7bKvip9ykM+yjRo3IGKlRCZWQwVy+8H3XKL00zyGHav247gG4qAH+qiP5zPCMGPYah7QMNiOrVtKgjI3wE4K4OX2zkCX939Mr1OtUvyk62pPELonitamX4hlDGQYDd9lmxhbx41aK7e2D96Qt7SjjWjbPfmnbEbJ2aQ/KgEqpT1OCmKnic1lQ3gvTN5r3DRO1uLfhb66PVrkrdUtlG872UX2lfA7FSHwyhfAY3QOsP+QxG0NSdd/IOksWhtzBnoS8JY5e9QIFQuXgA2Rabq31OcEF4tjx6Yr5NR3Zj6elG/Z80Cb04lg39t9gQtCuWGztl2QUs7L/GAh0dUkrtyyX005m/lTHKlMoIjbRhwfGhf/T74mB6XFAx+px0usrg1pNGKmAWx+trGYSLFcuAx61dHlmDqqo0c6WUelXGSM8Vk3A7RHltcPCC8ZpxmacLYAryqM3ukfa/0+rrdb8BTzJ7/HSWEoKHEPmjm/mZ52UiS/14AdyLp+jl2+zb7oiFuuBt9bqzuG/=xFFq")!
        
//        self.readLicense()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func readLicense() {
//        let contentFile = URL(fileURLWithPath: Bundle.main.path(forResource: "simpleGPG", ofType: "txt")!)
        let signedFile = URL(fileURLWithPath: Bundle.main.path(forResource: "license", ofType: "asc")!)
        do {
            let signedData = try Data(contentsOf: signedFile)
            print("signed data : \(signedData.count)")
            LicenceChecker.instance.readLicense(signedData: signedData)
        } catch (let error) {
            print("read file error : \(error.localizedDescription)")
        }
    }
    
    
    // MARK : action from UI
    @IBAction func touchSignBtn(_ sender: Any) {
        do {
            // Read data from license
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "license", ofType: nil)!))
            print("data from file : \(data.count)")
            // sign data
            let signedData = LicenceChecker.instance.sign(data: data)
            if signedData != nil {
                // write signed data to license.asc
                try signedData?.write(to: URL(fileURLWithPath: Bundle.main.path(forResource: "license", ofType: "asc")!))
                print("writting signed data is success")
            }
        } catch (let error) {
            print("sign error : \(error.localizedDescription)")
        }
    }
    
    @IBAction func touchVerifyBtn(_ sender: Any) {
        self.readLicense()
    }
    
}

