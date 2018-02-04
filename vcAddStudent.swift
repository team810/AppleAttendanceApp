//
//  vcAddStudent.swift
//  sva1
//
//  Created by scoring app code on 1/22/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import UIKit
import Firebase

class vcAddStudent: UIViewController {
    var newStudent: Student = Student()
    var delegate: addSceneData? = nil

    @IBOutlet var txtStudentId: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtFirstName: UITextField!
    
    let ref = Database.database().reference()
    
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
        
        let a: Int? = Int(txtStudentId.text!)
        
        ref.child("Users").child("userNumber").observeSingleEvent(of: .value, with: {snapshot in
            var usrNmbr: Int = snapshot.value as! Int
            usrNmbr = usrNmbr + 1
            self.ref.child("Users").child("userNumber").setValue(usrNmbr)
            
            self.ref.child("Users").child("\(usrNmbr)").child("first").setValue(self.txtFirstName.text)
            self.ref.child("Users").child("\(usrNmbr)").child("last").setValue(self.txtLastName.text)
            self.ref.child("Users").child("\(usrNmbr)").child("id").setValue(a)
        })
        
        
        
        delegate?.getNewStudentData(newStudent: newStudent)
        dismiss(animated: true, completion: nil)
    }

}
