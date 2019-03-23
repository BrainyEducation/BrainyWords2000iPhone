//
//  XMLParserExtension.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 9/30/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit
import SWXMLHash

extension XMLElement{
    
    var background: String {
        return self.attribute(by: "android:background")?.text ?? ""
    }
    
    var tag: String {
        return self.attribute(by: "android:tag")?.text ?? ""
    }
    
    var layoutWidth: String {
        return self.attribute(by: "android:layout_width")?.text ?? ""
    }
    
    var layoutHeight: String {
        return self.attribute(by: "android:layout_height")?.text ?? ""
    }
    
    var layoutMarginTop: String {
        return self.attribute(by: "android:layout_marginTop")?.text ?? ""
    }
    
    var layoutMarginBottom: String {
        return self.attribute(by: "android:layout_marginBottom")?.text ?? ""
    }
    
    var layoutMarginLeft: String {
        return self.attribute(by: "android:layout_marginLeft")?.text ?? ""
    }
    
    var layoutMarginRight: String {
        return self.attribute(by: "android:layout_marginRight")?.text ?? ""
    }
    
    var layoutAlignParentTop: Bool {
        let text = self.attribute(by: "android:layout_alignParentTop")?.text ?? ""
       return text.stringToBool
    }
    
    var layoutAlignParentBottom: Bool {
        let text = self.attribute(by: "android:layout_alignParentBottom")?.text ?? ""
        return text.stringToBool
    }
    
    var layoutAlignParentLeft: Bool {
        let text = self.attribute(by: "android:layout_alignParentLeft")?.text ?? ""
        return text.stringToBool
    }
    
    var layoutAlignParentRight: Bool {
        let text = self.attribute(by: "android:layout_alignParentRight")?.text ?? ""
        return text.stringToBool
    }
    
    var layoutCenterHorizontal: Bool{
        let text = self.attribute(by: "android:layout_centerHorizontal")?.text ?? ""
        return text.stringToBool
    }
    
    var layoutCenterVertical: Bool{
        let text = self.attribute(by: "android:layout_centerVertical")?.text ?? ""
        return text.stringToBool
    }
    
    var layoutAbove: String {
        return self.attribute(by: "android:layout_above")?.text ?? ""
    }
    
    var layoutBelow: String {
        return self.attribute(by: "android:layout_below")?.text ?? ""
    }
    
    var layoutToRightOf: String {
        return self.attribute(by: "android:layout_toRightOf")?.text ?? ""
    }
    
    var layoutToLeftOf: String {
        return self.attribute(by: "android:layout_toLeftOf")?.text ?? ""
    }
    
}

extension String{
    var stringToBool: Bool{
        if self.lowercased() == "true" { return true }
        return false
    }
}
