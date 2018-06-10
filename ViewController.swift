//
//  ViewController.swift
//  sva1
//
//  Created by scoring app code on 1/17/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import UIKit
import Firebase

protocol addSceneData {
    func getNewStudentData(newStudent: Student)
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, addSceneData
{
    var delTeamInfo: AppDelegate?
    
    //@IBOutlet  var lblName: UILabel!
    @IBOutlet var tblStudentList: UITableView!
    
    public var students: [Student] = [Student]()
    var cellIdentifier = "cellStudent"
    //var s = Student()
    var sc = StudentCell()
    let ref = Database.database().reference()
    var currentUserNumber = Int()
    var filteredStudents = [Student]()
    
    //var student: Student? { didSet { self.updateUI() }}
    
    var switchReference: DatabaseReference?
    var switchHandle: DatabaseHandle?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @objc let date = Date()
    var currentDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //s.vc = self
        //s.load()
        
        filteredStudents = students
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tblStudentList.tableHeaderView = searchController.searchBar
        
        self.tblStudentList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMddYYYY"
        
        currentDate = formatter.string(from: date)
        print(currentDate)
        
        ref.child("Users").observe(.value) { (snapshot) in
            print(snapshot)
            self.filteredStudents.removeAll()
            self.students.removeAll()
            for child in snapshot.children{
                let userSnap = child as! DataSnapshot
                let userSnapData = userSnap.value
                let userDict = userSnapData as! [String:Any]
                //if userDict["First"] as? String != "" || userDict["First"] as? String != nil{
                  //  if userDict["Last"] as! String != "" || userDict["Last"] as! String != nil{
                    //    if userDict["ID"] as! String != "" || userDict["ID"] as! String != nil{
                            let user = Student(snapshot: userSnap)
                            if(user.FirstName != "" && user.LastName != "" && user.StudentId != ""){
                                self.filteredStudents.append(user)
                                self.students = self.filteredStudents
                                self.tblStudentList.reloadData()
                            }
                      //  }
                    //}
                //}
                
            }
            self.sortByFirst()
        }
        
        //ref.child("attendance").child(Global.shared.currentDate).observe(.childChanged, with: snap)
        /*switchReference = ref.child("Users")
        switchReference?.observe(.childAdded, with: { [weak self] (snapshot: DataSnapshot) in
            let newUser = snapshot.value
            //print(newUser as Any)
            var s: Student = Student()
            s = Student()
            
            if let firebaseDic = snapshot.value as? [String: AnyObject] // unwrap it since its an optional
            {
                s.FirstName = (firebaseDic["First"] as! String)
                print(s.FirstName!)
                s.LastName = firebaseDic["Last"] as? String
                s.StudentId = firebaseDic["ID"] as? String
                self?.getNewStudentData(newStudent: s)
            }
            else
            {
                print("Error retrieving FrB data") // snapshot value is nil
            }
        })*/
        
        // Do any additional setup after loading the view, typically from a nib.
        self.tblStudentList.register(UITableViewCell.self,  forCellReuseIdentifier: "cell")
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? vcAddStudent {
            dest.delegate = self
            // this doesn't need to be here for add
            // something like it will need to be here for edit
            dest.newStudent = Student()
        }
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredStudents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StudentCell = self.tblStudentList.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StudentCell
        
        let student = filteredStudents[indexPath.row]
        cell.student = student
        if student.isPresent == true{
            cell.lblStudentAttending.isOn = true
        } else{
            cell.lblStudentAttending.isOn = false
        }
        
        return cell
    }
    
    @IBAction func sort(_ sender: Any) {
        let sortedUsers = students.sorted { $0.LastName!.lowercased() < $1.LastName!.lowercased() }
        students = sortedUsers
        filteredStudents = students
        tblStudentList.reloadData()
    }
    
    func sortByFirst() {
        let sortedUsers = students.sorted { $0.FirstName!.lowercased() < $1.FirstName!.lowercased() }
        students = sortedUsers
        filteredStudents = students
        tblStudentList.reloadData()
    }
    
    @IBAction func sortByFirstPressed(_ sender: Any) {
        let sortedUsers = students.sorted { $0.FirstName!.lowercased() < $1.FirstName!.lowercased() }
        students = sortedUsers
        filteredStudents = students
        tblStudentList.reloadData()
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if sender.isOn == true{
            if let cell = sender.superview?.superview as? StudentCell {
                let indexPath = tblStudentList.indexPath(for: cell)
                //let index = tblStudentList.cellForRow(at: indexPath!)
                cell.lblStudentAttending.isOn = false
                print(indexPath!)
            }
        } else{
            if let cell = sender.superview?.superview as? StudentCell{
                cell.lblStudentAttending.isOn = false
            }
        }
    }
    
    func getNewStudentData(newStudent: Student) {
        students.append(newStudent)
        filteredStudents = students
        self.tblStudentList.reloadData()
    }
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredStudents = students
        } else {
            // Filter the results
            filteredStudents = students.filter { $0.FullName().lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.tblStudentList.reloadData()
    }
    
}
