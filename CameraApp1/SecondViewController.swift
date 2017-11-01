//
//  SecondViewController.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 7/3/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import AVFoundation

class SecondViewController: UIViewController {
    
    

    override func viewDidLoad() {

        super.viewDidLoad()

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var username_input: UITextField!
    
    @IBOutlet weak var password_input: UITextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    

@IBAction func setButtonText1(_ sender: Any) {
   
    
    if segmentControl.selectedSegmentIndex == 1
        
    {
        signupButton.setTitle("Sign Up", for: UIControlState.normal)
    }
    else{
        signupButton.setTitle("Log In", for: UIControlState.normal)
        
    }

    
}
    
    

@IBAction func doSignUp(_ sender: Any) {
        let email = self.username_input.text
        let password = self.password_input.text
        
        
        if email != "" && password != ""
        {
            if segmentControl.selectedSegmentIndex == 1 //signup
            
            {
                
                Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
                    if error == nil {
                        print("You have successfully signed up")
                        // Goes to main page
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                        self.present(vc!, animated: true, completion: nil)
                        self.performSegue(withIdentifier: "segue", sender: self)
                        let request = Auth.auth().currentUser?.createProfileChangeRequest()
                        request?.displayName = email
                        
                    }
                    else {
                        if (error?.localizedDescription) != nil
                        {
                            print(error?.localizedDescription as Any)
                            let myError2 = error?.localizedDescription
                            print(myError2!)
                            
                        }
                    }
                })
            }
        }
        
        
    
            
    if segmentControl.selectedSegmentIndex == 0 {
    //login
    
    Auth.auth().signIn(withEmail: self.username_input.text!, password: self.password_input.text!, completion: { (user, error) in
    if user != nil
    {
    self.performSegue(withIdentifier: "segue", sender: self)
    //sign in user
    }
    else
    {
    if (error?.localizedDescription) != nil
    {
    _ = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
    
    let myError = error?.localizedDescription
    print(myError!)
    
            }
    else {
        Auth.auth().signIn(withEmail: self.username_input.text!, password: self.password_input.text!, completion: { (user, error) in
            if user != nil
            {
                self.performSegue(withIdentifier: "segue", sender: self)
                //sign in user
            }
            else
            {
                if (error?.localizedDescription) != nil
                {
                    _ = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let myError1 = error?.localizedDescription
                    print(myError1!)

        }
    
    }
}
)}
}
}
)
}
}
}
