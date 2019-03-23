//
//  Network.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 2/26/19.
//  Copyright © 2019 HMD Avengers. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import SwiftyJSON

typealias TeacherLoginResultHandler = (TeacherResponse?) -> ()
typealias ListStudentsResultHandler = ([StudentDataResponse]?) -> ()
typealias StudentLoginResultHandler = (StudentResponse?) -> ()
typealias StudentAlyticsResultHandler = (AnalyticResponse?) -> ()
typealias StudentAddNewResultHandler = (StudentResponse?) -> ()
class Network: NSObject {

    static let shared = Network()
    
    struct URL {
        static let rootURL = "https://teacherportal.hearatale.com/"
        static let apiURL = rootURL + "api/"
        static let teacherLogin = apiURL + "session/login/"
        static let studentLogin = apiURL + "session/student/"
        static let listStudents = apiURL + "students/"
        static let analytic = apiURL + "analytics/application/"
        static let addStudent = apiURL + "student"
    }
    
    static var authorizedHeader: [String: String]{
        return ["Authorization": "Bearer " + (RootConstants.token ?? "") ]
    }
    
    static var programID:String = "5c77aa85b9cc5e1f7c9439d5"
    
    @discardableResult func teacherLogin(email: String, password: String, resultHandler: TeacherLoginResultHandler?) -> DataRequest{
        let params = ["email": email,
                      "password": password]
        return Alamofire.request(Network.URL.teacherLogin,
                                 method: .post,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: nil)
        .responseObject { (response: DataResponse<TeacherResponse>) in
            resultHandler?(response.result.value)
        }
    }
    
    @discardableResult func studentLogin(id: String, resultHandler: StudentLoginResultHandler?) -> DataRequest{
        let params = ["id": id]
        return Alamofire.request(Network.URL.studentLogin,
                                 method: .post,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: nil)
            .responseObject { (response: DataResponse<StudentResponse>) in
                resultHandler?(response.result.value)
        }
    }
    
    @discardableResult func fetchStudents(resultHandler: ListStudentsResultHandler?) -> DataRequest{
        return Alamofire.request(Network.URL.listStudents,
                                 method: .get,
                                 parameters: nil,
                                 encoding: URLEncoding.default,
                                 headers: Network.authorizedHeader)
            .responseObject { (response: DataResponse<ListStudentsResponse>) in
                resultHandler?(response.result.value?.data)
        }
    }
    
    @discardableResult func analyticsStudents(data:AnalyticDataResponse,resultHandler: StudentAlyticsResultHandler?) -> DataRequest{
    
        let dataJson : [String:Any] = ["student":data.student_id,
                                        "program":Network.programID,
                                        "focus_item":data.focus_item_id,
                                        "correct_on":data.correct_on,
                                        "time_spent":data.time_spent]
        
        return Alamofire.request(Network.URL.analytic,
                                 method: .post,
                                 parameters: dataJson,
                                 encoding: JSONEncoding.default,
                                 headers: Network.authorizedHeader)
            .responseObject { (response: DataResponse<AnalyticResponse>) in
                resultHandler?(response.result.value)
            }
        }
    
    @discardableResult func addNewStudent(studentID:String,resultHandler: StudentAddNewResultHandler?) -> DataRequest{
        
        let dataJson : [String:Any] = ["teacher":RootConstants.teacher_id_long ?? "",
                                       "student_id":studentID,
                                       "delete":"false"]
        
        return Alamofire.request(Network.URL.addStudent,
                                 method: .post,
                                 parameters: dataJson,
                                 encoding: JSONEncoding.default,
                                 headers: Network.authorizedHeader)
            .responseObject { (response: DataResponse<StudentResponse>) in
                resultHandler?(response.result.value)
        }
    }

}
    

