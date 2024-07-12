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
    var locationFetcher:LocationFetcher!
    
    let lblTitleDemoSwitchView = UILabel()
    
    let lblOptionalView01 = UILabel()
    let swtchOptionalView01 = UISwitch()
    
    let lblOptionalView02 = UILabel()
    let swtchOptionalView02 = UISwitch()

    let lblOptionalView03 = UILabel()
    let swtchOptionalView03 = UISwitch()
    
    let lblOptionalView04 = UILabel()
    let swtchOptionalView04 = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        setup_DemoSwitchViews()
        print("-- DemoSwitchView init --")
        userStore = UserStore.shared
        locationFetcher = LocationFetcher.shared
       
        
//        /* Option 1: Offline and user.email is nil*/
//        userStore.isOnline = false
//        userStore.user.email = nil
        /* Option 2: Online and user.email is nil*/
        userStore.isOnline = true
        userStore.user.email = nil
        userStore.user.username = nil
//        /* Option 3: Online and user.email is something*/
//        userStore.isOnline = true
//        userStore.user.email = "email@some_domain.com"
//        userStore.user.username = "email"
//        /* Option 4: Offline and user.email is something*/
//        userStore.isOnline = false
//        userStore.user.email = "email@some_domain.com"
//        userStore.user.username = "email"
        
    
        
        
        
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
        
        
        lblOptionalView01.text = "Option 1 (Offline GenericUsername): "
        lblOptionalView01.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblOptionalView01)
        lblOptionalView01.accessibilityIdentifier="lblOptionalView01"
        
        
        swtchOptionalView01.accessibilityIdentifier = "swtchOptionalView01"
        swtchOptionalView01.translatesAutoresizingMaskIntoConstraints = false
        swtchOptionalView01.addTarget(self, action: #selector(switchValueChanged_01(_:)), for: .valueChanged)
        self.addSubview(swtchOptionalView01)
        
        lblOptionalView02.text = "Option 2 (Online GenericUsername):  "
        lblOptionalView02.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblOptionalView02)
        lblOptionalView02.accessibilityIdentifier="lblOptionalView02"
        
        
        swtchOptionalView02.accessibilityIdentifier = "swtchOptionalView02"
        swtchOptionalView02.translatesAutoresizingMaskIntoConstraints = false
        swtchOptionalView02.addTarget(self, action: #selector(switchValueChanged_02(_:)), for: .valueChanged)
        self.addSubview(swtchOptionalView02)
        
        lblOptionalView03.text = "Option 3 (Online Real email):  "
        lblOptionalView03.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblOptionalView03)
        lblOptionalView03.accessibilityIdentifier="lblOptionalView03"
        
        
        swtchOptionalView03.accessibilityIdentifier = "swtchOptionalView03"
        swtchOptionalView03.translatesAutoresizingMaskIntoConstraints = false
        swtchOptionalView03.addTarget(self, action: #selector(switchValueChanged_03(_:)), for: .valueChanged)
        self.addSubview(swtchOptionalView03)
        
        
        
        lblOptionalView04.text = "Option 4 (Offline Real email): "
        lblOptionalView04.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblOptionalView04)
        lblOptionalView04.accessibilityIdentifier="lblOptionalView04"
        
        
        swtchOptionalView04.accessibilityIdentifier = "swtchOptionalView04"
        swtchOptionalView04.translatesAutoresizingMaskIntoConstraints = false
        swtchOptionalView04.addTarget(self, action: #selector(switchValueChanged_04(_:)), for: .valueChanged)
        self.addSubview(swtchOptionalView04)
        
        
        NSLayoutConstraint.activate([
            lblTitleDemoSwitchView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            lblTitleDemoSwitchView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lblTitleDemoSwitchView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            
            lblOptionalView01.topAnchor.constraint(equalTo: lblTitleDemoSwitchView.bottomAnchor, constant: 50),
            lblOptionalView01.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            swtchOptionalView01.centerYAnchor.constraint(equalTo: lblOptionalView01.centerYAnchor),
            swtchOptionalView01.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            lblOptionalView02.topAnchor.constraint(equalTo: lblOptionalView01.bottomAnchor, constant: 20),
            lblOptionalView02.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            swtchOptionalView02.centerYAnchor.constraint(equalTo: lblOptionalView02.centerYAnchor),
            swtchOptionalView02.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            lblOptionalView03.topAnchor.constraint(equalTo: lblOptionalView02.bottomAnchor, constant: 20),
            lblOptionalView03.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            swtchOptionalView03.centerYAnchor.constraint(equalTo: lblOptionalView03.centerYAnchor),
            swtchOptionalView03.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            lblOptionalView04.topAnchor.constraint(equalTo: lblOptionalView03.bottomAnchor, constant: 20),
            lblOptionalView04.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            swtchOptionalView04.centerYAnchor.constraint(equalTo: lblOptionalView04.centerYAnchor),
            swtchOptionalView04.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            swtchOptionalView04.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])

        
    }
    
    /* Objc Methods*/
    @objc private func switchValueChanged_01(_ sender: UISwitch) {
        
        if sender.isOn {
            userStore.isOnline = false
            userStore.user.email = nil
            userStore.user.username = nil
            
            print("DemoSwitchView switch 01 is ON - Offline AND GenericUsername")
            // This switch is disabled -- handled by:  case_option_1_Offline_and_generic_name
//            self.swtchOptionalView01.isEnabled = false
            
            // All other switches turned off
            self.swtchOptionalView02.isOn = false
            self.swtchOptionalView03.isOn = false
            self.swtchOptionalView04.isOn = false
            
            // All other switches enabled
            self.swtchOptionalView02.isEnabled = true
            self.swtchOptionalView03.isEnabled = true
            self.swtchOptionalView04.isEnabled = true
            
//            delegate?.remove_vwUserStatus()
//            delegate?.remove_vwOffline()
            delegate?.case_option_1_Offline_and_generic_name()
           
//            print("userStore.user.username: \(userStore.user.username)")
            
        }
    }
    
    @objc private func switchValueChanged_02(_ sender: UISwitch) {
        
        if sender.isOn {
            userStore.isOnline = true
            userStore.user.email = nil
            userStore.user.username = nil
            
            delegate!.vwUserStatus.setup_vcRegistrationButton()
            
            print("DemoSwitchView switch 02 is ON - Online AND GenericUsername")
            // This switch is disabled: handled by: case_option_2_Online_and_generic_name
//            self.swtchOptionalView02.isEnabled = false
            
            // All other switches turned off
            self.swtchOptionalView01.isOn = false
            self.swtchOptionalView03.isOn = false
            self.swtchOptionalView04.isOn = false
            
            // All other switches enabled
            self.swtchOptionalView01.isEnabled = true
            self.swtchOptionalView03.isEnabled = true
            self.swtchOptionalView04.isEnabled = true
            
            delegate?.case_option_2_Online_and_generic_name()
        }
    }
    
    @objc private func switchValueChanged_03(_ sender: UISwitch) {
        
        if sender.isOn {
            userStore.isOnline = true
            userStore.user.email = "email@some_domain.com"
            userStore.user.username = "email"
            
            delegate!.vwUserStatus.setup_vcRegistrationButton()
            
            print("DemoSwitchView switch 02 is ON - Online AND GenericUsername")
            // This switch is disabled: handled by: case_option_2_Online_and_generic_name
//            self.swtchOptionalView02.isEnabled = false
            
            // All other switches turned off
            self.swtchOptionalView01.isOn = false
            self.swtchOptionalView02.isOn = false
            self.swtchOptionalView04.isOn = false
            
            // All other switches enabled
            self.swtchOptionalView01.isEnabled = true
            self.swtchOptionalView02.isEnabled = true
            self.swtchOptionalView04.isEnabled = true
            
            delegate?.case_option_3_Online_and_custom_email()
        }
    }
    
    @objc private func switchValueChanged_04(_ sender: UISwitch) {
        
        if sender.isOn {
            userStore.isOnline = true
            userStore.user.email = "email@some_domain.com"
            userStore.user.username = "email"
            
//            delegate!.vwUserStatus.setup_vcRegistrationButton()
            delegate!.vwUserStatus.remove_vcRegistrationButton()
            
            print("DemoSwitchView switch 02 is ON - Online AND GenericUsername")
            // This switch is disabled -- handled by: case_option_4_Offline_and_custom_email
//            self.swtchOptionalView04.isEnabled = false
            
            // All other switches turned off
            self.swtchOptionalView01.isOn = false
            self.swtchOptionalView02.isOn = false
            self.swtchOptionalView03.isOn = false
            
            // All other switches enabled
            self.swtchOptionalView01.isEnabled = true
            self.swtchOptionalView02.isEnabled = true
            self.swtchOptionalView03.isEnabled = true
            
            delegate?.case_option_4_Offline_and_custom_email()
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
//    func setup_vwOffline()
//    func remove_vwOffline()
//    func setup_vwUserStatus()
//    func remove_vwUserStatus()
    var constraints_Offline_NoEmail:[NSLayoutConstraint] {get}
    var constraints_Online_NoEmail:[NSLayoutConstraint] {get}
    var constraints_Offline_YesEmail:[NSLayoutConstraint] {get}
    
    func case_option_1_Offline_and_generic_name()
    func case_option_2_Online_and_generic_name()
    func case_option_3_Online_and_custom_email()
    func case_option_4_Offline_and_custom_email()
    
    var vwUserStatus:UserVcUserStatusView {get}
}
