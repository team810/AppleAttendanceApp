//
//  StudentClass.swift
//  sva1
//
//  Created by scoring app code on 1/19/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import Foundation
class Student:NSObject, NSCoding{
    override init() {
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(FirstName, forKey: Constants().FirstName)
        aCoder.encode(LastName, forKey: Constants().LastName)
        aCoder.encode(StudentId, forKey: Constants().StudentId)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let firstName = aDecoder.decodeObject(forKey: Constants().FirstName) as! String
        let lastName = aDecoder.decodeObject(forKey: Constants().LastName) as! String
        let studentId = aDecoder.decodeObject(forKey: Constants().StudentId) as! String
        self.init(_firstName: firstName, _lastName: lastName, _StudentId: studentId )
    }
    init (_firstName: String, _lastName: String, _StudentId: String) {
        FirstName = _firstName
        LastName = _lastName
        StudentId = _StudentId
    }
    var FirstName: String?
    var LastName: String?
    var StudentId: String?
    func FullName() ->String {
        var fname = FirstName
        if FirstName == nil {
            fname = ""
        }
        var lname = LastName
        if LastName == nil {
            lname = ""
        }
        return fname! + " " + lname!
        
    }
    func save(StudentList: [Student]) {
        /* UserDefaults.standard.set([1,2,3], forKey:"dummy")
        var dummyArrayOfInts = UserDefaults.standard.array(forKey: "dummy")
 */
        // you can't save an array of a custom object
        // need to change them to NSData
        // let s = Student();
        let studentData = NSKeyedArchiver.archivedData(withRootObject: StudentList)
       
        let userDefaults = UserDefaults.standard//save to storage device
        userDefaults.set(studentData, forKey: Constants().StudentList)
        
        var i = 1
    }
    func load() -> [Student] {
        let userDefaults = UserDefaults.standard
        if let decoded = userDefaults.object(forKey: Constants().StudentList) as? NSData{
            return NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Student]
        }
        return [Student]()
    }
    func wipeClean() {
        let StudentList: [Student] = [Student]()
        let studentData = NSKeyedArchiver.archivedData(withRootObject: StudentList)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(studentData, forKey: Constants().StudentList)
    }
}
struct Constants {
    let StudentList = "StudentList"
    let TeamName = "TeamName"
    let FirstName = "FirstName"
    let LastName = "LastName"
    let StudentId = "StudentId"
}
