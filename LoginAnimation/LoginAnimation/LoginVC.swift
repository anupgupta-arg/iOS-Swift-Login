//
//  LoginVC.swift
//  LoginAnimation
//
//  Created by Anup Gupta Developer on 07/03/18.
//  Copyright © 2018 GeekGuns. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate,CountdownTimerDelegate,CountryListDelegate {
    
    

    @IBOutlet var otpTextField1: UITextField!
    @IBOutlet var otpTextField2: UITextField!
    @IBOutlet var otpTextField3: UITextField!
    @IBOutlet var otpTextField4: UITextField!
    @IBOutlet var otpViewConstraint: NSLayoutConstraint!
    @IBOutlet var loginView: UIView!
    @IBOutlet var nameTextField: ACFloatingTextfield!
    @IBOutlet var mobileNumberTextField: ACFloatingTextfield!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var resendOtpButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var showUserMobileNumberLabel: UILabel!
    @IBOutlet var countdownTimerLabel: UILabel!
    @IBOutlet var countryCodeButton: UIButton!
    
    @IBOutlet var termsAndPolicyView: UIView!
    
    @IBOutlet var termsAndPolicyLabel: UILabel!
    
    @IBOutlet var UniqolabelLogo: UIImageView!
    var countryList = CountryList()
     var mobileNumberStr : String = "+91"
    // Mark: - countdown Timer Var
    
    var countdownTimerDidStart = false
    
    lazy var countdownTimer: CountdownTimer = {
        let countdownTimer = CountdownTimer()
        return countdownTimer
    }()
    
    
    // Test, for dev
    let selectedSecs:Int = 10
    
    
    
    var activeField: UITextField?
    var otpFieldConstraint : CGFloat = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        countryList.delegate = self
        setPasswordFieldUI()
        setCountdownProperty()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPasswordFieldUI() {
        otpTextField1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpTextField2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpTextField3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpTextField4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        otpFieldConstraint = otpViewConstraint.constant
        print("otpViewConstraint.constant:::",otpViewConstraint.constant);
        let blueColor = UIColor.init(red: 5.0/255.0, green: 142.0/255.0, blue: 223/255.0, alpha: 1)
        otpTextField1.layer.borderColor = blueColor.cgColor
        otpTextField2.layer.borderColor = blueColor.cgColor
        otpTextField3.layer.borderColor = blueColor.cgColor
        otpTextField4.layer.borderColor = blueColor.cgColor
        otpTextField1.layer.borderWidth = 2.0
        otpTextField2.layer.borderWidth = 2.0
        otpTextField3.layer.borderWidth = 2.0
        otpTextField4.layer.borderWidth = 2.0
        
        // set borderColor and borderWidth of login view
//        loginView.layer.borderWidth = 2.0
//        loginView.layer.cornerRadius = 5.0
//        loginView.layer.borderColor = blueColor.cgColor
//
        
        // resend otp button is hidden Initial
        resendOtpButton.isHidden = true
     
//      loginView = loginView.showBorder()
//      signupButton = signupButton.showShadow() as! UIButton
        let lightGrayColor = UIColor.lightGray
        loginView.showShadow(color: lightGrayColor, opacity: 1, offSet: CGSize(width:-1, height: 5), radius: 5, scale: true)
        loginView.showBorder(color: blueColor, radius: 5.0, width: 2.0)
        signupButton.showShadow(color: lightGrayColor, opacity: 0.5, offSet: CGSize(width:-1, height: 5), radius: 2, scale: true)
        signupButton.showBorder(color: lightGrayColor, radius: 5.0, width: 0.5)
        
        resendOtpButton.showShadow(color: lightGrayColor, opacity: 0.5, offSet: CGSize(width:-1, height: 5), radius: 2, scale: true)
        resendOtpButton.showBorder(color: lightGrayColor, radius: 5.0, width: 0.5)
        UniqolabelLogo.image = UIImage.gifImageWithName("uniqo")
        
    }
    

    @objc func textFieldDidChange(textField: UITextField){
        print("222222222")
        let text = textField.text
        
        print("text?.count",text?.count as Any)
        if  text!.count >= 1 {
            switch textField{
            case otpTextField1:
                otpTextField2.becomeFirstResponder()
            case otpTextField2:
                otpTextField3.becomeFirstResponder()
            case otpTextField3:
                otpTextField4.becomeFirstResponder()
            case otpTextField4:
                otpTextField4.resignFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
                
            case otpTextField1:
                otpTextField1.becomeFirstResponder()
            case otpTextField2:
                otpTextField1.becomeFirstResponder()
            case otpTextField3:
                otpTextField2.becomeFirstResponder()
            case otpTextField4:
                otpTextField3.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            print("YES NOOOOOOOO")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField {
          
            mobileNumberTextField.becomeFirstResponder()
        }
        
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField || textField == mobileNumberTextField {
            return true
        }
        else{
            guard let text = textField.text else { return true}
            
            let newLength = text.count + string.count - range.length
            return newLength <= 1
        }
        
        
    }
    
    @IBAction func ShowAndHideOtpField(_ sender: Any) {
        let buttonTag = (sender as AnyObject).tag
        
        
        switch buttonTag {
            
        case 11?: // Sign up button press to show OTP Fields
            
            let isvalidName = SignUpLogicWithOTP.getSingleton().isVaildName(name: nameTextField.text!)
            let isvalidMobileNo = SignUpLogicWithOTP.getSingleton().isValidMobileNumber(mobileNo: mobileNumberTextField.text!)
            guard isvalidName else{
                nameTextField.showErrorWithText(errorText: "Enter Correct Name")
                return
                
            }
            guard isvalidMobileNo else{
                mobileNumberTextField.showErrorWithText(errorText: "Enter Correct Mobile Number")
                return
            }
            
//            otpViewConstraint.constant = 8
//            resendOtpButton.isHidden = false
//            resendOtpButton.isEnabled = false
//            signupButton.setTitle("PROCEED", for: .normal)
//            signupButton.tag = 31;
            prepareDataToCallOtpAPI()
            
        case 21?: // Back Button Press
            otpViewConstraint.constant = otpFieldConstraint
            otpTextField1.text = ""
            otpTextField2.text = ""
            otpTextField3.text = ""
            otpTextField4.text = ""
            resendOtpButton.isHidden = true
            signupButton.setTitle("SIGN UP", for: .normal)
            signupButton.tag = 11;
            countdownTimer.stop()
            
        case 31?: // after entering otp PROCEED call api for otp Verification
            print("PROCEED")
            prepareDataToVerifyOtp()
            
        default:
            print("default")
        }
       
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }){(animationComplete) in
//            print("yes")
        }
    }
    
    
    @IBAction func clearButtonAction(_ sender: Any) {
        otpTextField1.text = ""
        otpTextField2.text = ""
        otpTextField3.text = ""
        otpTextField4.text = ""
        otpTextField1.becomeFirstResponder()
    }
    
    @IBAction func resendOtpButtonAction(_ sender: Any) {
        prepareDataToCallOtpAPI()
    }
    
   
    func prepareDataToCallOtpAPI() {
        
        
        let params : [String: AnyObject] = ["full_name" : nameTextField.text as AnyObject ,
                                            "mobile_number" : mobileNumberTextField.text as AnyObject,
                                            "country_code" : mobileNumberStr as AnyObject,
                                            "auth_id" : AuthIdValue as AnyObject,
                                            "auth_token" : AuthTokenValue as AnyObject,
                                            
                ]
        
        let returnDic = SignUpLogicWithOTP.getSingleton().getOptApi(params: params as NSDictionary)
        if !returnDic.isKind(of: NSNull.self) {
            otpViewConstraint.constant = 8
            resendOtpButton.isHidden = false
            resendOtpButton.isEnabled = false
            signupButton.setTitle("PROCEED", for: .normal)
            signupButton.tag = 31;
            showUserMobileNumberLabel.text = "Number Entered is \(mobileNumberTextField.text!)"
            countdownTimer.start()
        }
        else{
            
        }
        
        
    }
    func prepareDataToVerifyOtp() {

        let otpString : String = "\(otpTextField1.text!)\(otpTextField2.text!)\(otpTextField3.text!)\(otpTextField4.text!)"
         let params : [String: AnyObject] = ["otp" : otpString as AnyObject ,
                                            "mobile_number" : mobileNumberTextField.text as AnyObject,
                                            "country_code" : "+91" as AnyObject,
                                            "auth_id" : AuthIdValue as AnyObject,
                                            "auth_token" : AuthTokenValue as AnyObject,
                                            ]
        
        let returnDic = SignUpLogicWithOTP.getSingleton().varifyOtp(params: params as NSDictionary)
        if !returnDic.isKind(of: NSNull.self) {
           
        }
        else{
            
        }
        
        
    }

    
    // Mark : keyboard Function
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height + 50, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    
    
    //MARK: - Countdown Timer Delegate
    
    func countdownTime(time: (hours: String, minutes: String, seconds: String)) {
        
        //         var hoursString : String = time.hours
        let minutesString : String = time.minutes
        let secondsString : String = time.seconds
        countdownTimerLabel.text = "Waiting For OTP \(minutesString) : \(secondsString)"
    }
    
    
    func countdownTimerDone() {
        print("countdownTimerDone")
        resendOtpButton.isEnabled = true
        countdownTimerLabel.text = "Check the Number And Try Again"
    }
    // Mark: - Countdown timer Function
    func setCountdownProperty() {
        countdownTimer.delegate = self
        countdownTimer.setTimer(hours: 0, minutes: 0, seconds: selectedSecs)
    }
    
    // Mark:- Country Code Delegate
    func selectedCountry(country: Country) {
//        self.selectedCountryLabel.text
//        let countyString: String  = "\(country.flag!) \(country.name!), \(country.countryCode), \(country.phoneExtension)"
//        print("country Name:",countyString)
        countryCodeButton.setTitle("+\(country.phoneExtension)", for: .normal)
        mobileNumberStr = (countryCodeButton.titleLabel?.text)!
    }
    
    @IBAction func countryCodeButtonAction(_ sender: Any) {
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    
    @available(iOS 10.0, *)
    @IBAction func termsButtonAction(_ sender: Any) {
        openUrl(url: TermsUrl)
    }
    
    @IBAction func PrivacyPolicyButtonAction(_ sender: Any) {
        openUrl(url: PrivacyPolicyUrl)
    }
   
    func openUrl(url : String) {
        if let url = URL(string: url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                // Fallback on earlier versions
                 UIApplication.shared.openURL(url)
            }
        }
    }
    
}
extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
}






