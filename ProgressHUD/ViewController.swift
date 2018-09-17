//
//  ViewController.swift
//  ProgressHUD
//
//  Created by Massimo Biolcati on 9/10/18.
//  Copyright © 2018 Massimo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var styleSegmentedControl: NSSegmentedControl!
    @IBOutlet var maskSegmentedControl: NSSegmentedControl!
    @IBOutlet var positionSegmentedControl: NSSegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @IBAction func showIndeterminate(_ sender: Any) {
        view.showProgressHUD(title: "Doing Stuff", message: "Completing something…", mode: .indeterminate, settings: demoSettings, duration: 2)
    }

    @IBAction func showDeterminateCircular(_ sender: Any) {
        view.showProgressHUD(title: "Determinate Progress", message: "Almost done…", mode: .determinate, settings: demoSettings)
        DispatchQueue.global(qos: .default).async {
            var progress = 0.0
            for _ in 0..<100 {
                usleep(10000)
                progress += 0.01
                self.view.setProgressHUDProgress(progress)
            }
            self.view.hideProgressHUD()

        }
    }

    @IBAction func showCustomView(_ sender: Any) {
        var settings = demoSettings
        let image = NSImage(named: "unicorn")!
        let imageView = NSImageView(frame: NSRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        imageView.image = image
        settings.customView = imageView
        view.showProgressHUD(title: "Custom View", message: "I am not a horse", mode: .customView, settings: settings, duration: 2)
    }

    @IBAction func showTextOnly(_ sender: Any) {
        view.showProgressHUD(title: "Message 🎸", message: "Showing text only.\nOn multiple lines.\nSquashed much?", mode: .text, settings: demoSettings, duration: 2)
    }

    private var demoSettings: ProgressHUDSettings {
        var settings = ProgressHUDSettings()
        settings.mode = .indeterminate
        settings.maskType = hudMaskType
        settings.style = hudStyle
        settings.position = hudPosition
        return settings
    }

    private var hudStyle: ProgressHUDStyle {
        switch styleSegmentedControl.selectedSegment {
        case 0: return .light
        default: return .dark
        }
    }

    private var hudMaskType: ProgressHUDMaskType {
        switch maskSegmentedControl.selectedSegment {
        case 0: return .none
        case 1: return .clear
        case 2: return .black
        case 3: return .gradient
        default: return .none
        }
    }

    private var hudPosition: ProgressHUDPosition {
        switch positionSegmentedControl.selectedSegment {
        case 0: return .top
        case 1: return .center
        default: return .bottom
        }
    }

}
