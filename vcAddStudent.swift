//
//  vcAddStudent.swift
//  sva1
//
//  Created by scoring app code on 1/22/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import UIKit
import Firebase

class vcAddStudent: UIViewController, UITextFieldDelegate {
    //var newStudent: Student = Student()
    var delegate: addSceneData? = nil

    @IBOutlet var txtStudentId: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtFirstName: UITextField!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtStudentId.delegate = self
        txtStudentId.keyboardType = .numberPad
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
        //newStudent.FirstName = txtFirstName.text
        //newStudent.LastName = txtLastName.text
        //newStudent.StudentId = txtStudentId.text
        
        ref.observeSingleEvent(of: .value, with: {snapshot in
            /*if snapshot.hasChild("userNumber"){
                self.ref.child("userNumber").observeSingleEvent(of: .value, with: {snapshot in
                    var usrNmbrString: String = snapshot.value as! String
                    var usrNmbr = Int(usrNmbrString)!
                    usrNmbr = usrNmbr + 1
                    
                    self.ref.child("userNumber").setValue("\(usrNmbr)")
                    
                    
                    
                    self.ref.child("Users").child("\(usrNmbr)").child("First").setValue(self.txtFirstName.text)
                    self.ref.child("Users").child("\(usrNmbr)").child("Last").setValue(self.txtLastName.text)
                    self.ref.child("Users").child("\(usrNmbr)").child("ID").setValue(self.txtStudentId.text)
                })
            }
            else{
                self.ref.child("userNumber").setValue("0")
                let usrNmbr:Int = 1
                self.ref.child("userNumber").setValue("\(usrNmbr)")
                self.ref.child("Users").child("\(usrNmbr)").child("First").setValue(self.txtFirstName.text)
                self.ref.child("Users").child("\(usrNmbr)").child("Last").setValue(self.txtLastName.text)
                self.ref.child("Users").child("\(usrNmbr)").child("ID").setValue(self.txtStudentId.text)
            }*/
            self.ref.child("Users").childByAutoId().setValue(["First":self.txtFirstName.text! as NSString, "Last":self.txtLastName.text! as! NSString , "ID":self.txtStudentId.text! as! NSString])
            
        })
        
        //delegate?.getNewStudentData(newStudent: newStudent)
        dismiss(animated: true, completion: nil)
    }

}
