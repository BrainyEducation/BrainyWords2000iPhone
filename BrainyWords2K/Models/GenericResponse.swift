//
//  GenericResponse.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 2/26/19.
//  Copyright © 2019 HMD Avengers. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseResponse: Mappable {
    
    var isSuccess: Bool{
        return status.contains("ok")
    }
    
    private var status = ""

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
    }
}

class GenericObjectResponse<T: Mappable>: BaseResponse {

    var data: T?

}

class GenericArrayResponse<T: Mappable>: BaseResponse {
    
    var data: [T]?
    
}

class TeacherResponse: GenericObjectResponse<TeacherDataResponse>{
    var token = ""
    var status = ""
    var message = ""
    override func mapping(map: Map) {
        token <- map["token"]
        data <- map["teacher"]
        status <- map["status"]
        message <- map["message"]
    }
}

class TeacherDataResponse: Mappable{
    var id = ""
    var name = ""
    var email = ""
    var teacher_id = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        name <- map["name"]
        email <- map["email"]
        teacher_id <- map["teacher_id"]
    }
}

class StudentResponse: GenericObjectResponse<StudentDataResponse>{
    var token = ""
    var statusResponse = ""
    var message = ""
    override func mapping(map: Map) {
        token <- map["token"]
        data <- map["student"]
        statusResponse <- map["status"]
        message <- map["message"]
    }
}

class ListStudentsResponse: GenericArrayResponse<StudentDataResponse>{
     var statusResponse = ""
    override func mapping(map: Map) {
        data <- map["students"]
        statusResponse <- map["status"]
    }
}

class StudentDataResponse: Mappable{
    var id = ""
    var student_id = ""
    var teacher_id = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        student_id <- map["student_id"]
        teacher_id <- map["teacher"]
    }
}

class AnalyticResponse: GenericObjectResponse<AnalyticDataResponse>{
    var statusResponse = ""
    override func mapping(map: Map) {
        statusResponse <- map["status"]
        data <- map["analytic"]
    }
}

class AnalyticDataResponse: Mappable{
    
    var id = ""
    var student_id = ""
    var program_id = ""
    var focus_item_id = ""
    var correct_on = 0
    var time_spent = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        student_id <- map["student"]
        program_id <- map["program"]
        focus_item_id <- map["focus_item"]
        correct_on <- map["correct_on"]
        time_spent <- map["time_spent"]
    }
}

