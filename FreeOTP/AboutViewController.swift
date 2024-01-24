//
//  AboutViewController.swift
//  FreeOTP
//
//  Created by Justin Stephenson on 6/23/20.
//  Copyright © 2020 Fedora Project. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
  // Perform multiple link text replacements in a given string
  func addHyperLinksToText(originalText: String, hyperLinks: [String: String]) {
    let style = NSMutableParagraphStyle()
    style.alignment = .left
    let attributedOriginalText = NSMutableAttributedString(string: originalText)
    for (hyperLink, urlString) in hyperLinks {
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSRange(location: 0, length: attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 18), range: fullRange)

        var textColor = UIColor()
        if #available(iOS 13.0, *) {
            textColor = UIColor.secondaryLabel
        } else {
            textColor = UIColor.gray
        }

        attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: fullRange)
    }

    self.linkTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
    ]
    self.attributedText = attributedOriginalText
  }
}

class AboutViewController : UIViewController, UITextViewDelegate {
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!

    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        versionLabel.text = "TitleOTP \(appVersion)"
        versionLabel.font = UIFont.boldSystemFont(ofSize: 28.0)

        aboutTextView.delegate = self
        aboutTextView.text = """
        TitleOTP by Razi Title, Inc.

        This application is a custom adaptation of FreeOTP, which was initially developed by Red Hat, Inc. now IBM, among others. Our customizations make it ideally suited for the unique operational requirements of the real estate title community.

        Original Copyright Notice:
        2013-2020 - Red Hat, Inc., and other original authors.

        License Information:
        FreeOTP is licensed under the Apache License, Version 2.0 (the "License"), which is available at http://www.apache.org/licenses/LICENSE-2.0

        Disclaimer of Warranty:
        This software is provided by Razi Title, Inc., "as is" and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall Razi Title, Inc., its affiliates, or its licensors be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.

        Limitation of Liability:
        Neither Razi Title, Inc., nor any of its affiliates, shall be liable for any damages of any kind resulting from the use or inability to use this software, including but not limited to direct, indirect, incidental, punitive, and consequential damages.

        TitleOTP® is a registered trademark of Razi Title, Inc. All rights reserved. The use of the TitleOTP trademark without explicit permission is prohibited. If you are interested in obtaining permission to use the TitleOTP trademark, please contact us for licensing opportunities. We reserve the right to grant or deny permission at our discretion, ensuring the trademark's use aligns with our brand and standards. For inquiries, please reach out to trademark@razititle.com.

        Feedback and Support:
        We are committed to the continuous improvement of TitleOTP. If you have any issues or require assistance, please reach out to us:

        - support@titleotp.com
        - www.titleotp.com

        Your security and satisfaction are our top priorities. Thank you for choosing TitleOTP for your secure authentication needs.
        """

        aboutTextView.addHyperLinksToText(originalText: aboutTextView.text,
                                          hyperLinks:
            ["Apache 2.0": "https://www.apache.org/licenses/LICENSE-2.0.html"])
    }
}
