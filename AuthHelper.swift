//
//  AuthHelper.swift
//  Flourish-Teaching
//
//  Created by Cesar Devers on 3/14/15.
//  Copyright (c) 2015 Cesar Devers. All rights reserved.
//

import UIKit

final public class AuthHelper: NSObject {
    class var key: String {
        return "testKey"
    }
    
    public class func encrypt(input: String!, password: String? = nil) -> (string: String?, data: NSData?) {
        let data = input.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        let pass = (password != nil) ? password : self.key
        let encryptedData = Crypto.encryptData(data, password: password, error: nil)
        let encryptedString = encryptedData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        return (string: encryptedString, data: encryptedData)
    }
    
    public class func decrypt(input: String!, password: String? = nil) -> (string: String?, data: NSData?) {
        let pass = (password != nil) ? password : self.key
        let encryptedData = NSData(base64EncodedString: input, options: NSDataBase64DecodingOptions(rawValue:0))
        let decryptedData = Crypto.decryptData(encryptedData, password: pass, error: nil)
        let decryptedText = NSString(data: decryptedData, encoding: NSUTF8StringEncoding) as? String
        
        return (string: decryptedText, data: decryptedData)
    }
}
    