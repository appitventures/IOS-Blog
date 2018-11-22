

import UIKit

import LocalAuthentication

class AppHelper {
    
}


/// Get device related information
extension AppHelper {
    
    static func getDeviceID() -> String {
        
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    static func getBuildNumber() -> String {
        
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
    
    static func getVersionNumber() -> String {
        
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    static func getCurrentLanguage() -> String {
        
        return Locale.current.languageCode!
    }
    
    class var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // 44.0 on iPhone X, 20.0 on iPhone 8 on iOS 12+.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
}

/// View controllers related
extension AppHelper {
    
    class func topMostController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }
    
    class func showAlertOnRootViewController(title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            
            AppHelper.topMostController().present(alert, animated: true, completion: nil)
        }
    }
    
    
}




extension AppHelper {
    
    func phoneNumberFormatter(_ text: String?, _ range: NSRange, _ string: String) -> (String, Bool) {
        let newString = (text! as NSString).replacingCharacters(in: range, with: string)
        let digitsString = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let decimalString = digitsString.joined(separator: "") as NSString
        let length = decimalString.length
        let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
        if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
            let newLength = (text! as NSString).length + (string as NSString).length - range.length as Int
            return (newLength > 10) ? (text!, false) : (text!, true)
        }
        var index = 0 as Int
        let formattedString = NSMutableString()
        if hasLeadingOne {
            formattedString.append("1")
            index += 1
        }
        if (length - index) > 3 {
            let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", areaCode)
            index += 3
        }
        if length - index > 3 {
            let prefix = decimalString.substring(with: NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }
        let remainder = decimalString.substring(from: index)
        formattedString.append(remainder)
        let finalText = formattedString as String
        return (finalText, false)
    }
    
}

extension AppHelper {
    
    func printJSONObject(data: Data) {
        do {
            let json = try? JSONSerialization.jsonObject(with: data, options : .allowFragments)
            dump(json)
        }
    }
}








