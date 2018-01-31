//
//  vcAddStudent.swift
//  sva1
//
//  Created by scoring app code on 1/22/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import UIKit

class vcAddStudent: UIViewController {
    var newStudent: Student = Student()
    var delegate: addSceneData? = nil

    @IBOutlet var txtStudentId: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtFirstName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: UIButton) {
        newStudent.FirstName = txtFirstName.text
        newStudent.LastName = txtLastName.text
        newStudent.StudentId = txtStudentId.text
        delegate?.getNewStudentData(newStudent: newStudent)
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
