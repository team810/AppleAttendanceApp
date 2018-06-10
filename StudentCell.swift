//
//  StudentCell.swift
//  sva1
//
//  Created by scoring app code on 1/19/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import UIKit
import Firebase
class StudentCell: UITableViewCell {
    var student: Student? { didSet { self.updateUI() }}
    
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var lblStudentId: UILabel!
    @IBOutlet weak var lblStudentAttending: UISwitch!

    let ref = Database.database().reference()
    
    var user: Student! {
        didSet{
            lblStudentName.text = user.FullName()
            lblStudentId.text = user.StudentId
            lblStudentAttending.isOn = false
        }
    }
    
    var switchReference: DatabaseReference?
    var switchHandle: DatabaseHandle?
    
    func stopObservation() {
        if let handle = switchHandle {
            switchReference?.removeObserver(withHandle: handle)
        }
    }
    
    func startObservation() -> Bool {
        stopObservation()
        
        if let uid = student?.StudentId {
            switchReference = ref.child("attendance").child(Global.shared.currentDate).child(uid)
            switchReference?.observe(.value, with: { [weak self] (snapshot: DataSnapshot) in
                DispatchQueue.main.async {
                    let isOn = (snapshot.value as? Bool) ?? false
                    self?.lblStudentAttending.isOn = isOn
                    self?.student?.isPresent = isOn
                }
            })
        }
        stopObservation()
        return lblStudentAttending.isOn
    }
    
    override func prepareForReuse(){
        lblStudentAttending.isOn = false
        stopObservation()
    }
    
    func updateUI() {
        lblStudentAttending.isOn = startObservation()
        self.lblStudentName.text = self.student?.FullName() ?? ""
        self.lblStudentId.text = self.student?.StudentId ?? ""
    }
    
    @IBAction func `switch`(_ sender: UISwitch)  {
        switchReference?.setValue(sender.isOn)
    }
}
