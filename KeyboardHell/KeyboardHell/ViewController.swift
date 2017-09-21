//
//  ViewController.swift
//  KeyboardHell
//
//  Created by Steven Berard on 9/20/17.
//  Copyright © 2017 Event Farm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: .main) { (notification) in

            print("Keyboard will show")
            let userInfo = notification.userInfo

            guard let keyboardRect = userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }

            var keyboardHeight = keyboardRect.height

            if #available(iOS 11.0, *) {
                let bottomSafeAreaHeight = self.view.safeAreaInsets.bottom
                keyboardHeight -= bottomSafeAreaHeight
            } else {
                // Fallback on earlier versions
            }

            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
//            self.scrollView.contentOffset.y = keyboardHeight
        }

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: .main) { (notification) in

            print("Keyboard will hide")
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
//            self.scrollView.contentOffset.y = 0
        }
    }

    @IBAction func userTappedOnTheBackground(_ sender: Any) {
        view.endEditing(true)
    }

}

