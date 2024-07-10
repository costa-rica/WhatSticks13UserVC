//
//  DemoSwitchView.swift
//  WhatSticks13UserVC
//
//  Created by Nick Rodriguez on 10/07/2024.
//

import UIKit

class DemoSwitchView: UIView {
    
    weak var delegate: DemoSwitchViewDelegate?
    var userStore: UserStore!
    
    let lblTitleDemoSwitchView = UILabel()
    
    let lblOptionalView01 = UILabel()
    let swtchOptionalView01 = UISwitch()
    
    let lblOptionalView02 = UILabel()
    let swtchOptionalView02 = UISwitch()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        setup_DemoSwitchViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_DemoSwitchViews()
    }
    
    func setup_DemoSwitchViews(){
        lblTitleDemoSwitchView.text = "Demo Switches"
        lblTitleDemoSwitchView.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblTitleDemoSwitchView.numberOfLines = 0
        lblTitleDemoSwitchView.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblTitleDemoSwitchView)
        lblTitleDemoSwitchView.accessibilityIdentifier="lblTitleDemoSwitchView"
        
        
        lblOptionalView01.text = "Optional View 01: "
        lblOptionalView01.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblOptionalView01)
        lblOptionalView01.accessibilityIdentifier="lblOptionalView01"
        
        
        swtchOptionalView01.accessibilityIdentifier = "swtchOptionalView01"
        swtchOptionalView01.translatesAutoresizingMaskIntoConstraints = false
        swtchOptionalView01.addTarget(self, action: #selector(switchValueChanged_01(_:)), for: .valueChanged)
        self.addSubview(swtchOptionalView01)
        
        lblOptionalView02.text = "Optional View 02: "
        lblOptionalView02.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblOptionalView02)
        lblOptionalView02.accessibilityIdentifier="lblOptionalView02"
        
        
        swtchOptionalView02.accessibilityIdentifier = "swtchOptionalView02"
        swtchOptionalView02.translatesAutoresizingMaskIntoConstraints = false
        swtchOptionalView02.addTarget(self, action: #selector(switchValueChanged_02(_:)), for: .valueChanged)
        self.addSubview(swtchOptionalView02)
        
        
        NSLayoutConstraint.activate([
            lblTitleDemoSwitchView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            lblTitleDemoSwitchView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lblTitleDemoSwitchView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            
            lblOptionalView01.topAnchor.constraint(equalTo: lblTitleDemoSwitchView.bottomAnchor, constant: 50),
            lblOptionalView01.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            swtchOptionalView01.centerYAnchor.constraint(equalTo: lblOptionalView01.centerYAnchor),
            swtchOptionalView01.leadingAnchor.constraint(equalTo: lblOptionalView01.trailingAnchor, constant: 5),
            
            lblOptionalView02.topAnchor.constraint(equalTo: lblOptionalView01.bottomAnchor, constant: 20),
            lblOptionalView02.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            swtchOptionalView02.centerYAnchor.constraint(equalTo: lblOptionalView02.centerYAnchor),
            swtchOptionalView02.leadingAnchor.constraint(equalTo: lblOptionalView02.trailingAnchor, constant: 5),

            swtchOptionalView02.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])

        
    }
    
    /* Objc Methods*/
    @objc private func switchValueChanged_01(_ sender: UISwitch) {
        
        if sender.isOn {

            print("DemoSwitchView switch 01 is ON")
            self.swtchOptionalView02.isOn = false
            delegate?.remove_vwUserStatus()
            delegate?.setup_vwOffline()
        } else {
            
            print("DemoSwitchView switch 01  is OFF")
            delegate?.remove_vwUserStatus()
            self.swtchOptionalView02.isOn = true
        }
    }
    
    @objc private func switchValueChanged_02(_ sender: UISwitch) {
        
        if sender.isOn {

            print("DemoSwitchView switch 02 is ON")
            self.swtchOptionalView02.isOn = false
            delegate?.remove_vwOffline()
            delegate?.setup_vwUserStatus()
        } else {

            print("DemoSwitchView switch 02  is OFF")
            delegate?.remove_vwUserStatus()
            self.swtchOptionalView01.isOn = true
        }
    }
    
}


// Protocol definition
protocol DemoSwitchViewDelegate: AnyObject {
    //    func didUpdateWeatherInfo(_ weatherInfo: String)
    func removeSpinner()
    func showSpinner()
    func templateAlert(alertTitle:String,alertMessage: String,  backScreen: Bool)
    func presentAlertController(_ alertController: UIAlertController)
    func touchDown(_ sender: UIButton)
    func setup_vwOffline()
    func remove_vwOffline()
    func setup_vwUserStatus()
    func remove_vwUserStatus()
}
