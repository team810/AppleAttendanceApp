//
//  ViewController.swift
//  sva1
//
//  Created by scoring app code on 1/17/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import UIKit
protocol addSceneData {
    func getNewStudentData(newStudent: Student)
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, addSceneData
{
    var delTeamInfo: AppDelegate?
    
    @IBOutlet  var lblName: UILabel!
    @IBOutlet var txtText1: UITextField!
    @IBOutlet var tblStudentList: UITableView!
    public var students: [Student] = [Student]()
    var cellIdentifier = "cellStudent"
    override func viewDidLoad() {
        super.viewDidLoad()
        students = Student().load()
        // Do any additional setup after loading the view, typically from a nib.
        self.tblStudentList.register(UITableViewCell.self,  forCellReuseIdentifier: "cell")
    }
    @IBAction func sayHi(_ sender: Any) {
        let name = txtText1.text
        let helloMsg = "hello \(name!)"
        let alertController = UIAlertController(title: "My App", message: helloMsg, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnNextScreen(_ sender: Any) {
        performSegue(withIdentifier: "gotoNextScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ViewController2 {
            dest.helloWorld = txtText1.text
        }
        if let dest = segue.destination as? vcAddStudent {
            dest.delegate = self
            // this doesn't need to be here for add
            // something like it will need to be here for edit
            dest.newStudent = Student()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StudentCell = self.tblStudentList.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StudentCell
        
        let student = students[indexPath.row]
        
        cell.lblStudentName.text = student.FullName()
        cell.lblStudentId.text = student.StudentId
        return cell //UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func saveStudentList(_ sender: Any) {
        Student().save(StudentList: students)
    }
    func getNewStudentData(newStudent: Student) {
        students.append(newStudent)
        self.tblStudentList.reloadData()
    }
}

