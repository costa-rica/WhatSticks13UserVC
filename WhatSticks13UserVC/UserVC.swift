//
//  ViewController.swift
//  WhatSticks13UserVC
//
//  Created by Nick Rodriguez on 10/07/2024.
//

import UIKit

class UserVC: TemplateVC, UserVcLocationDayWeatherDelegate, UserVcOfflineDelegate, UserVcRegisterButtonDelegate, DemoSwitchViewDelegate {
    
    var userStore: UserStore!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let vwDemoSwitch = DemoSwitchView()
    let vwUserVcLine00=UIView()
    
    
    let vwFindAppleHealthPermissions = UserVcFindAppleHealthPermissionsView()
    let vwUserVcLine01=UIView()
    let vwLocationDayWeather = UserVcLocationDayWeather()
    let vwUserVcLine02=UIView()

    let vwOffline = UserVcOffline()
    var constraints_Offline_NoEmail = [NSLayoutConstraint]()
    
    let vwUserStatus = UserVcUserStatusView()
    var constraints_Online_NoEmail = [NSLayoutConstraint]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwDemoSwitch.delegate = self // Assign the delegate
        vwOffline.delegate = self // Assign the delegate
        vwUserStatus.vwRegisterButton.delegate = self// Assign the delegate
        userStore = UserStore.shared
        
        /* Conditions */
        // #1: Is device offline?
        userStore.isOffline = true
        
        // #2: Email?
//        userStore.user.email = "email@some_domain.com"
        userStore.user.username = "ambivalent_elf_0000"
        vwUserStatus.btnUsernameFilled.setTitle(userStore.user.username, for: .normal)
        
        
        // Do any additional setup after loading the view.
        self.setup_TopSafeBar()
        setupScrollView()
        setupContentView()
        
        setup_vwDemoSwitch()
        setup_vwUserVcLine00()
        
        setup_vwFindAppleHealthPermissions()
        setup_vwUserVcLine01()
        setup_vwLocationDayWeather()
        setup_vwUserVcLine02()
        contentView.backgroundColor = .purple
        
        
        
        constraints_Offline_NoEmail = [
            vwOffline.topAnchor.constraint(equalTo: vwUserVcLine02.topAnchor),
            vwOffline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwOffline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwOffline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        constraints_Online_NoEmail = [
            vwUserStatus.topAnchor.constraint(equalTo: vwUserVcLine02.topAnchor),
            vwUserStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserStatus.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        if userStore.isOffline, userStore.user.email == nil {
            remove_vwUserStatus()
            setup_vwOffline()
        }
        else if !userStore.isOffline, userStore.user.email == nil{
            remove_vwOffline()
            setup_vwUserStatus()
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
    
    func setup_vwUserVcLine02(){
        vwUserVcLine02.accessibilityIdentifier = "vwUserVcLine02"
        vwUserVcLine02.translatesAutoresizingMaskIntoConstraints = false
        vwUserVcLine02.backgroundColor = UIColor(named: "lineColor")
        contentView.addSubview(vwUserVcLine02)
        NSLayoutConstraint.activate([
            vwUserVcLine02.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwUserVcLine02.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserVcLine02.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserVcLine02.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func setup_vwOffline(){
        vwOffline.accessibilityIdentifier = "vwOffline"
        vwOffline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwOffline)
        NSLayoutConstraint.activate(constraints_Offline_NoEmail)
    }
    func remove_vwOffline(){
        NSLayoutConstraint.deactivate(constraints_Offline_NoEmail)
        vwOffline.removeFromSuperview()
    }
    
    func setup_vwUserStatus(){
        vwUserStatus.accessibilityIdentifier = "vwUserStatus"
        vwUserStatus.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwUserStatus)
        NSLayoutConstraint.activate(constraints_Online_NoEmail)
    }
    func remove_vwUserStatus(){
        NSLayoutConstraint.deactivate(constraints_Online_NoEmail)
        vwUserStatus.removeFromSuperview()
    }
    

    
}

