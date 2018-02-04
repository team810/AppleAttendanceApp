//
//  StudentClass.swift
//  sva1
//
//  Created by scoring app code on 1/19/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import Foundation
import Firebase

class Student:NSObject, NSCoding{
    
    let ref = Database.database().reference()
    var vc: ViewController?
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
        /*let userDefaults = UserDefaults.standard
        if let decoded = userDefaults.object(forKey: Constants().StudentList) as? NSData{
            return NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Student]
        }*/
        var students: [Student] = [Student]()
        self.ref.child("Users").child("userNumber").observeSingleEvent(of: .value, with: {
            snapshot in
            
            let item = snapshot.value as? Int
            var count: Int = item!
            var s: Student = Student()
            var i : Int = 1
            let group = DispatchGroup()

            for _ in 1...count{
                
                group.enter()

                self.ref.child("Users").child("\(i)").child("first").observeSingleEvent(of: .value, with: {snapshot in
                    s = Student()
                    let name = snapshot.value as? String
                    let test: String = name!
                    s.FirstName = test
                    print(test)
                    
                })
                self.ref.child("Users").child("\(i)").child("last").observeSingleEvent(of: .value, with: {snapshot in
                    let last = snapshot.value as? String
                    let test: String = last!
                    s.LastName = last
                    //print("\(i) \(test)")
                })
                self.ref.child("Users").child("\(i)").child("id").observeSingleEvent(of: .value, with: {snapshot in
                    let id = snapshot.value as? Int
                    let idString : String = "\(id!)"
                    s.StudentId = idString
                    self.vc?.students.append(s)
                    group.leave()
                    //print(s.StudentId)
                    //print("\(i) \(id)")
                })
                i = i + 1
                // students.append(s)
                //print(s.FirstName)
                //s.save(StudentList: students)

                
                
            }
            group.notify(queue: .main) {
                
                self.vc?.tblStudentList.reloadData()
                print("All callbacks are completed")
            }
            let userDefaults = UserDefaults.standard
            userDefaults.set("Robotics", forKey: Constants().TeamName)
            
        })
        
        return students //[Student]()
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
