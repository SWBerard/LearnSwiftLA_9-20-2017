//
//  ViewController.swift
//  EFKeyboardTutorial
//
//  Created by Steven Berard on 9/19/17.
//  Copyright © 2017 Event Farm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: .main) { (notification) in

            guard let keyboardEndFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
                print("Error: Keyboard did not have an end frame!")
                return
            }

            var safeAreaBottomInset:CGFloat = 0

            if #available(iOS 11.0, *) {
                print("safe area insets: \(self.view.safeAreaInsets)")
                safeAreaBottomInset = self.view.safeAreaInsets.bottom
            }

            var offset = self.view.frame.height - safeAreaBottomInset - keyboardEndFrame.origin.y

            if offset < 0 {
                offset = 0
            }

            print("offset should be: \(offset)")

            let contentInsets = UIEdgeInsetsMake(0, 0, offset, 0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
        }
    }

    @IBAction func userTappedBackground(_ sender: Any) {
        view.endEditing(true)
    }
}
