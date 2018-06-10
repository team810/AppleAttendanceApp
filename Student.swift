//
//  StudentClass.swift
//  sva1
//
//  Created by scoring app code on 1/19/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import Foundation
import Firebase

class Student:NSObject{//, NSCoding{
    //required init?(coder aDecoder: NSCoder) {
    //}
    
    
    let ref = Database.database().reference()
    let ref1 : DatabaseReference!
    var vc: ViewController?
    var sc: StudentCell?
    var isPresent:Bool = false
    
    @objc let date = Date()
    var currentDate = ""
    let formatter = DateFormatter()
    
    init(snapshot:DataSnapshot) {
        ref1 = snapshot.ref
        if let value = snapshot.value as? [String : Any]{
            FirstName = value["First"] as? String
            LastName = value["Last"] as? String ?? " "
            StudentId = value["ID"] as? String ?? " "
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(FirstName, forKey: Constants().FirstName)
        aCoder.encode(LastName, forKey: Constants().LastName)
        aCoder.encode(StudentId, forKey: Constants().StudentId)
    }
    
    /*required convenience init?(coder aDecoder: NSCoder) {
        let firstName = aDecoder.decodeObject(forKey: Constants().FirstName) as! String
        let lastName = aDecoder.decodeObject(forKey: Constants().LastName) as! String
        let studentId = aDecoder.decodeObject(forKey: Constants().StudentId) as! String
        self.init(_firstName: firstName, _lastName: lastName, _StudentId: studentId )
    }
    init (_firstName: String, _lastName: String, _StudentId: String) {
        FirstName = _firstName
        LastName = _lastName
        StudentId = _StudentId
    }*/
    var FirstName: String?
    var LastName: String?
    var StudentId: String?
    var signedIn = false
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
    }
    /*func load(){
        
        var count: Int = Int()
        self.ref.child("Users").child("userNumber").observeSingleEvent(of: .value, with: {
            snapshot in
            
            let item = snapshot.value as? Int
            count = item!
            var s: Student = Student()
            var i : Int = 1
            let group = DispatchGroup()
    
            for _ in 1...count{
                
                group.enter()

                self.ref.child("Users").child("\(i)").child("First").observeSingleEvent(of: .value, with: {snapshot in
                    s = Student()
                    let name = snapshot.value as? String
                    let test: String = name!
                    s.FirstName = test
                    print(test)
                })
                self.ref.child("Users").child("\(i)").child("Last").observeSingleEvent(of: .value, with: {snapshot in
                    let last = snapshot.value as? String
                    //let test: String = last!
                    s.LastName = last
                })
                self.ref.child("Users").child("\(i)").child("ID").observeSingleEvent(of: .value, with: {snapshot in
                    let id = snapshot.value as? Int
                    let idString : String = "\(id!)"
                    s.StudentId = idString
                    self.vc?.students.append(s)
                    group.leave()
                })
                i = i + 1
                
            }
            group.notify(queue: .main) {
                self.vc?.sortByFirst()
                self.vc?.filteredStudents = (self.vc?.students)!
                self.vc?.tblStudentList.reloadData()
                print("All callbacks are completed")
                //self.update()
            }
            let userDefaults = UserDefaults.standard
            userDefaults.set("Robotics", forKey: Constants().TeamName)
        })
    }*/
    
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
