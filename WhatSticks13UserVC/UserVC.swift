//
//  ViewController.swift
//  WhatSticks13UserVC
//
//  Created by Nick Rodriguez on 10/07/2024.
//

import UIKit

class UserVC: TemplateVC, UserVcLocationDayWeatherDelegate, UserVcOfflineDelegate, UserVcRegisterButtonDelegate, DemoSwitchViewDelegate, UserVcDeleteDelegate {
    
    var userStore: UserStore!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let vwDemoSwitch = DemoSwitchView()
    let vwUserVcLine00=UIView()
    
    let vwFindAppleHealthPermissions = UserVcFindAppleHealthPermissionsView()
    let vwUserVcLine01=UIView()
    let vwLocationDayWeather = UserVcLocationDayWeather()

    let vwOffline = UserVcOffline(frame: CGRect.zero, showLine: true)
    var constraints_Offline_NoEmail = [NSLayoutConstraint]()

    let vwUserStatus = UserVcUserStatusView(frame: CGRect.zero, showLine: true)
    var constraints_Online_NoEmail = [NSLayoutConstraint]()
    
    
    let vwUserDeleteAccount = UserVcDelete(frame: CGRect.zero, showLine: true)
    var constraints_Online_YesEmail = [NSLayoutConstraint]()
    
    var constraints_Offline_YesEmail = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-- UserVC viewDidLoad")
        vwDemoSwitch.delegate = self
        vwOffline.delegate = self
        vwUserStatus.vwRegisterButton.delegate = self
        userStore = UserStore.shared
        vwUserStatus.btnUsernameFilled.setTitle(userStore.user.username, for: .normal)
        
        self.setup_TopSafeBar()
        setupScrollView()
        setupContentView()
        
        setup_vwDemoSwitch()
        setup_vwUserVcLine00()
        
        setup_vwFindAppleHealthPermissions()
        setup_vwUserVcLine01()
        setup_vwLocationDayWeather()
        
        constraints_Offline_NoEmail = [
            vwOffline.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwOffline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwOffline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwOffline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        constraints_Online_NoEmail = [
            vwUserStatus.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwUserStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserStatus.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        constraints_Online_YesEmail = [
            vwUserStatus.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwUserStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            vwUserDeleteAccount.topAnchor.constraint(equalTo: vwUserStatus.bottomAnchor),
            vwUserDeleteAccount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserDeleteAccount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserDeleteAccount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        constraints_Offline_YesEmail = [
            vwUserStatus.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwUserStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            vwOffline.topAnchor.constraint(equalTo: vwUserStatus.bottomAnchor),
            vwOffline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwOffline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwOffline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        if !userStore.isOnline, userStore.user.email == nil {
            print("- case_option_1_Offline_and_generic_name()")
            case_option_1_Offline_and_generic_name()
        }
        else if userStore.isOnline, userStore.user.email == nil{
            print("- case_option_2_Online_and_generic_name()")
            case_option_2_Online_and_generic_name()
        }
        else if userStore.isOnline, userStore.user.email != nil{
            print("- case_option_3_Online_and_custom_email()")
            case_option_3_Online_and_custom_email()
        }
        else if !userStore.isOnline, userStore.user.email != nil{
            print("-case_option_4_Offline_and_custom_email()")
            case_option_4_Offline_and_custom_email()
        }
    }

    func setupScrollView() {
        // Set up the scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Set up constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupContentView() {
        // Set up the content view inside the scroll view
        contentView.accessibilityIdentifier = "contentView"
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Set up constraints for the content view
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // This ensures vertical scrolling
        ])
    }
    
    func setup_vwDemoSwitch(){
        
        vwDemoSwitch.accessibilityIdentifier = "vwDemoSwitch"
        vwDemoSwitch.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwDemoSwitch)
        
        // Set up constraints for the test labels view
        NSLayoutConstraint.activate([
            vwDemoSwitch.topAnchor.constraint(equalTo: contentView.topAnchor),
            vwDemoSwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwDemoSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setup_vwUserVcLine00(){
        vwUserVcLine00.accessibilityIdentifier = "vwUserVcLine00"
        vwUserVcLine00.translatesAutoresizingMaskIntoConstraints = false
        vwUserVcLine00.backgroundColor = UIColor(named: "lineColor")
        contentView.addSubview(vwUserVcLine00)
        NSLayoutConstraint.activate([
            vwUserVcLine00.topAnchor.constraint(equalTo: vwDemoSwitch.bottomAnchor),
            vwUserVcLine00.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserVcLine00.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserVcLine00.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func setup_vwFindAppleHealthPermissions(){
        vwFindAppleHealthPermissions.accessibilityIdentifier = "vwFindAppleHealthPermissions"
        vwFindAppleHealthPermissions.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwFindAppleHealthPermissions)
        
        // Set up constraints for the test labels view
        NSLayoutConstraint.activate([
            vwFindAppleHealthPermissions.topAnchor.constraint(equalTo: vwUserVcLine00.topAnchor),
            vwFindAppleHealthPermissions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwFindAppleHealthPermissions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setup_vwUserVcLine01(){
        vwUserVcLine01.accessibilityIdentifier = "vwUserVcLine01"
        vwUserVcLine01.translatesAutoresizingMaskIntoConstraints = false
        vwUserVcLine01.backgroundColor = UIColor(named: "lineColor")
        contentView.addSubview(vwUserVcLine01)
        NSLayoutConstraint.activate([
            vwUserVcLine01.topAnchor.constraint(equalTo: vwFindAppleHealthPermissions.bottomAnchor),
            vwUserVcLine01.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserVcLine01.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserVcLine01.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func setup_vwLocationDayWeather(){
        vwLocationDayWeather.accessibilityIdentifier = "vwLocationDayWeather"
        vwLocationDayWeather.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwLocationDayWeather)
        
        // Set up constraints for the test labels view
        NSLayoutConstraint.activate([
            vwLocationDayWeather.topAnchor.constraint(equalTo: vwUserVcLine01.topAnchor),
            vwLocationDayWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwLocationDayWeather.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            vwLocationDayWeather.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -5))
        ])
    }
    
    func setup_vwOffline(){
        print("-- adding vwOffline")
        vwOffline.accessibilityIdentifier = "vwOffline"
        vwOffline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwOffline)
        
    }

    func setup_vwUserStatus(){
        print("-- adding vwUserStatus")
        vwUserStatus.accessibilityIdentifier = "vwUserStatus"
        vwUserStatus.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwUserStatus)
    }
    
    func setup_vwUserDeleteAccount(){
        print("-- adding vwUserStatus")
        vwUserDeleteAccount.accessibilityIdentifier = "vwUserDeleteAccount"
        vwUserDeleteAccount.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwUserDeleteAccount)
    }
    
    func remove_optionalViews(){
        NSLayoutConstraint.deactivate(constraints_Offline_NoEmail)
        NSLayoutConstraint.deactivate(constraints_Online_NoEmail)
        NSLayoutConstraint.deactivate(constraints_Offline_YesEmail)
        NSLayoutConstraint.deactivate(constraints_Online_YesEmail)
        vwOffline.removeFromSuperview()
        vwUserStatus.removeFromSuperview()
        vwUserDeleteAccount.removeFromSuperview()
    }
    func case_option_1_Offline_and_generic_name(){
        remove_optionalViews()
        vwDemoSwitch.swtchOptionalView01.isOn = true
        vwDemoSwitch.swtchOptionalView01.isEnabled = false
        setup_vwOffline()
        NSLayoutConstraint.activate(constraints_Offline_NoEmail)
    }
    func case_option_2_Online_and_generic_name(){
        remove_optionalViews()
        vwDemoSwitch.swtchOptionalView02.isOn = true
        vwDemoSwitch.swtchOptionalView02.isEnabled = false
        setup_vwUserStatus()
        NSLayoutConstraint.activate(constraints_Online_NoEmail)
    }
    func case_option_3_Online_and_custom_email(){
        remove_optionalViews()
        setup_vwUserStatus()
        setup_vwUserDeleteAccount()
        NSLayoutConstraint.activate(constraints_Online_YesEmail)
    }
    func case_option_4_Offline_and_custom_email(){
        remove_optionalViews()
        vwDemoSwitch.swtchOptionalView04.isOn = true
        vwDemoSwitch.swtchOptionalView04.isEnabled = false
        setup_vwUserStatus()
        setup_vwOffline()
        NSLayoutConstraint.activate(constraints_Offline_YesEmail)
    }
    
}

