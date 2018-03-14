//
//  SignUpLogicWithOTP.swift
//  LoginAnimation
//
//  Created by Anup Gupta Developer on 08/03/18.
//  Copyright © 2018 GeekGuns. All rights reserved.
//

import UIKit
import Alamofire

class SignUpLogicWithOTP {
    
    private static var _instance: SignUpLogicWithOTP?;
    
    private init() {
        
    }
    
    public static func getSingleton() -> SignUpLogicWithOTP {
        if (SignUpLogicWithOTP._instance == nil) {
            SignUpLogicWithOTP._instance = SignUpLogicWithOTP.init();
        }
        return SignUpLogicWithOTP._instance!;
    }

    func isVaildName(name : String) -> Bool {
        
        do
        {
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z \\_]{2,30}$", options: .caseInsensitive)
            guard regex.matches(in: name, options: [], range: NSMakeRange(0, name.count)).count > 0 else {return false}
        }
        catch {
            
        }
        return true
        
        
        
        
//        do
//        {
//            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z \\_]{2,30}$", options: .caseInsensitive)
//            if regex.matches(in: name, options: [], range: NSMakeRange(0, name.count)).count > 0 {return true}
//        }
//        catch {
//
//        }
//        return false
        
       
        
//        guard name.rangeOfCharacter(from: CharacterSet.whitespaces) == nil else{
//            return false
//        }
//
//
//        return true
        
    }
    
    func  isValidMobileNumber(mobileNo : String ) -> Bool {

        
        
        do
        {
            let regex = try NSRegularExpression(pattern: "^[0-9]{7,15}$", options: .caseInsensitive)
            guard regex.matches(in: mobileNo, options: [], range: NSMakeRange(0, mobileNo.count)).count > 0 else {return false}
        }
        catch {
            
        }
        return true
        
        //        guard mobileNo.count >= 7 && mobileNo.count <= 15 else{
        //            return false
        //        }
        //        return true
        
        //        do
        //        {
        //            let regex = try NSRegularExpression(pattern: "^[0-9]{7,15}$", options: .caseInsensitive)
        //            if regex.matches(in: mobileNo, options: [], range: NSMakeRange(0, mobileNo.count)).count > 0 {return true}
        //        }
        //        catch {
        //
        //        }
        //        return false
    }
    
    func getOptApi(params : NSDictionary) -> NSDictionary{
        
        var result : NSDictionary = [:]
       AlamofireConnectionMangager.getSingleton().getDataFromServer( url: "\(BaseURL)\(KUserRegUrl)" , param : params as NSDictionary, success: {(responseResult) -> Void in
            
            print("responseResult :::",responseResult)
            print("Success")
            result = responseResult
        
        }, failure:{(error) -> Void in
            
            if (error != nil) {
                print("Somting went wrong")
            }

//            self.showAlert(alertMessage: "Somthing went wrong")
            
        })
        
       return result
    }
    func varifyOtp(params : NSDictionary) -> NSDictionary{
        
        var result : NSDictionary = [:]
        
        AlamofireConnectionMangager.getSingleton().getDataFromServer( url: "\(BaseURL)\(KVerifyOTPUrl)" , param : params as NSDictionary, success: {(responseResult) -> Void in
            
            print("responseResult :::",responseResult)
            print("Success")
            result = responseResult
            
        }, failure:{(error) -> Void in
            
            if (error != nil) {
                print("Somting went wrong")
            }
            
            //            self.showAlert(alertMessage: "Somthing went wrong")
            
        })
        
        return result
    }
    
}
