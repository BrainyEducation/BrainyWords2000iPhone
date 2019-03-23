//
//  StringExtension.swift
//  Dungnt
//
//

import Foundation
import UIKit
import MobileCoreServices

extension String {
    
    var dpToCGFloat: CGFloat {
        let newStr = self.replacingOccurrences(of: "dp", with: "")
        return CGFloat(Float(newStr) ?? 0)
    }
    
    var toNumber : Int{
        return Int(self.replace(target: ".", withString: "").replace(target: ",", withString: "")) ?? 0
    }
    var toDoubleNumber : Double{
        return Double(self.replace(target: ".", withString: "").replace(target: ",", withString: "")) ?? 0
    }
    
    func length() -> Int {
       return self.count
    }

    func hexadecimal() -> Data? {
        var data = Data(capacity: self.count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        
        guard data.count > 0 else { return nil }
        
        return data
    }
    
    var data : Data?{
        return self.data(using: String.Encoding.utf8)
    }
	
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func strippingPhone() -> String {
        let remove1 = self.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range:nil)
        let remove2 = remove1.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range:nil)
        let remove3 = remove2.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range:nil)
        return remove3
    }
	
    var strippingHTML : String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }

    func trimAll() -> String {
        return self.replace(target: " ", withString: "")
    }
    
    func toDouble() -> Double {
        return NumberFormatter().number(from: self)?.doubleValue ?? 0
    }
    
    func toFloat() -> Float {
        return NumberFormatter().number(from: self)?.floatValue ?? 0
    }
    
    func urlEncode() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
    }
    
    func isEmail() -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest : NSPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailTest.evaluate(with: self)
    }
    
    func isVietPhone() -> Bool{
        let phoneRegEx = "^((\\+84)|(84)|(0))[0-9]{9,10}$"
        let phoneTest : NSPredicate = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return !phoneTest.evaluate(with: self)
    }
    func isLaosPhone() -> Bool{
        let phoneRegEx = "((^(30)[0-9]{7})|(^(302|202|304|204|309|209|305|205|307|207)[0-9]{7})|(^(20)[0-9]{8}))$"
        let phoneTest : NSPredicate = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString)
    }
    
    func clearCurrencyFormat() -> String{
        return self.replace(target: ".", withString: "")
    }
    
    // LANGUAGE
    func bundleLanuage() -> Bundle{
        //vi.lproj
        
        if let lang_setting = UserDefaults.standard.object(forKey: "lang") as? String{
            if(lang_setting == "0"){
                return Bundle(path: Bundle.main.path(forResource: "lo-LA", ofType: "lproj")!)!
            }
            else{
                return Bundle(path: Bundle.main.path(forResource: lang_setting, ofType: "lproj")!)!
            }
        }
        else{
            if let bunder = Bundle.main.path(forResource: "lo-LA", ofType: "lproj"){
                return Bundle(path: bunder)!
            }
            else{
                return Bundle(path: Bundle.main.path(forResource: "Base", ofType: "lproj")!)!
            }
            
            
        }
    }
    
    var toLanguage : String{
        return self.bundleLanuage().localizedString(forKey: self, value:self, table:nil)
    }
    var tt : String{
        return self.bundleLanuage().localizedString(forKey: self, value:self, table:nil)
    }
    
    var URLEncodedString : String{
        return (self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? self)
    }
    
    var URLDecodedString : String{
        return (self.removingPercentEncoding ?? self)
    }

    var NameEncodeString : String {
         return self.replace(target: "/", withString: "%999")
    }
    
    var NameDecodedString : String {
        return self.replace(target: "%999", withString: "/")
    }
    
    //-----Khoi Nguyen 29/10/16
    /**
     Get name of a class
     
     - parameter aClass: Class
     
     
     
     - returns: Class name
     */
    static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func removePlusSign() -> String{
        return self.replacingOccurrences(of: "+", with: "")
    }

    /**
     Substring from specific index
     
     - parameter from: Index
     
     - returns: Substring value
     */
    func substringFrom(index: Int) -> String {
        return self.substring(from:self.index(self.startIndex, offsetBy: index))
    }
    //
    // MARK: - Convert to Date
    var commitmentDate: Date{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: self){
                return date
            }
            
            return Date()
        }
    }
    
    func substringTo(index: Int) -> String {
        return self.substring(to:self.index(self.startIndex, offsetBy: index))
    }
    
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    var attributeString: NSMutableAttributedString{
        return NSMutableAttributedString(string: self)
    }
    
    var decodedString: String? {
        
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        let options = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
            ] as [NSAttributedString.DocumentReadingOptionKey : Any]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        return attributedString.string
    }
    
    var isAudioExtension: Bool{
        
        if let fileExtension = self.fileExtension as CFString?{
            if let fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, nil){
                return UTTypeConformsTo(fileUTI.takeRetainedValue(), kUTTypeAudio) || self.fileExtension == "flac"
            }
        }
        
        return false
        
    }
    
    var fileExtension: String?{
        if let url = URL.init(string: self){
            return url.pathExtension
        }
        
        return (self as NSString).pathExtension
    }
    
//    var sha1: String {
//        let data = self.data(using: String.Encoding.utf8)!
//        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
//        data.withUnsafeBytes {
//            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
//        }
//        let hexBytes = digest.map { String(format: "%02hhx", $0) }
//        return hexBytes.joined()
//    }
    
    // MARK: - Calculating
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    var encodeURL: String? {
        let originalString = self
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return escapedString
    }
    
}

extension NSMutableAttributedString{
    
    func addAttribute(key: NSAttributedStringKey, value: Any, at string: String){
        self.addAttribute(key, value: value, range: NSRangeFromString(string))
    }
    
    func change(string : String, with color: UIColor){
        self.addAttribute(key: .foregroundColor, value: color, at: string)
    }
    
    func addAttribute(spacing: CGFloat, at string: String){
        self.addAttribute(key: .kern, value: spacing, at: string)
    }
    
    func addAttribute(lineSpacing: CGFloat, alignment: NSTextAlignment, at string: String){
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        
        // *** Apply attribute to string ***
        self.addAttribute(key: .paragraphStyle,
                          value: paragraphStyle,
                          at: string)
    }
    
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(.foregroundColor, value: color, range: range)
        }
    }
    
    func setStyleForText(_ textToFind: String,size:CGFloat, weight: UIFont.Weight) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(.font, value: UIFont.systemFont(ofSize: size, weight: weight), range: range)
        }
    }
    
    func setStyleItalicForText(_ textToFind: String, size:CGFloat) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(.font, value: UIFont.italicSystemFont(ofSize: size), range: range)
        }
    }
    
    func setcolorText(_ textToFind: String,size:CGFloat, color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(.foregroundColor, value:color , range: range)
        }
    }
    
    func setSearchBoldText(textbold:String, boldfont:UIFont){
        let boldFont = [NSAttributedStringKey.font:boldfont, NSAttributedStringKey.foregroundColor: UIColor.black]
        let range = self.mutableString.range(of: textbold, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttributes(boldFont, range: range)
        }
    }
}
