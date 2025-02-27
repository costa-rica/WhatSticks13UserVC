//
//  UserVcComponents.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 07/07/2024.
//

import UIKit


class UserVcFindAppleHealthPermissionsView: UIView {
    

    let lblTitle = UILabel()
    let lblDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        setup_labels()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_labels()
    }
    func setup_labels(){
//        print("--- we should see something in UserVcFindAppleHealthPermissionsView <-----")
//        self.backgroundColor = .green
        lblTitle.accessibilityIdentifier="lblTitle-UserVcFindAppleHealthPermissionsView"
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.text = "Apple Health Permissions"
        lblTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblTitle.numberOfLines=0
        self.addSubview(lblTitle)
//        lblTitle.backgroundColor = .colorRow1
        
        lblDescription.accessibilityIdentifier="lblDescription-UserVcFindAppleHealthPermissionsView"
        lblDescription.translatesAutoresizingMaskIntoConstraints=false
        let text_for_message = "Go to Settings > Health > Data Access & Devices > WhatSticks to grant access.\n\nFor this app to work properly please make sure all data types are allowed."
        lblDescription.text = text_for_message
        lblDescription.numberOfLines = 0
        self.addSubview(lblDescription)
//        lblDescription.backgroundColor = .colorRow2
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 3)),
            lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: heightFromPct(percent: 2)),
            lblDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            lblDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 3)),
            lblDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: heightFromPct(percent: -5))
        ])
    }
    
}

class UserVcLocationDayWeather: UIView {
    
    weak var delegate: UserVcLocationDayWeatherDelegate?
    
    var userStore: UserStore!
    var locationFetcher: LocationFetcher!
    let lblLocationDayWeatherTitle = UILabel()
    let lblLocationDayWeatherDetails = UILabel()
    // old name: LocationDayWeatherSwitch
    let stckVwLocTrackReoccurring=UIStackView()
    let lblLocTrackReoccurringSwitch=UILabel()
    let swtchLocTrackReoccurring = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        setup_views()
        print("- in UserVcLocationDayWeather")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_views()
    }
    
    
    private func setup_views(){
        userStore = UserStore.shared
        locationFetcher = LocationFetcher.shared
        lblLocationDayWeatherTitle.accessibilityIdentifier="lblLocationDayWeatherTitle"
        lblLocationDayWeatherTitle.text = "Location Weather Tracking"
        lblLocationDayWeatherTitle.translatesAutoresizingMaskIntoConstraints=false
        lblLocationDayWeatherTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblLocationDayWeatherTitle.numberOfLines = 0
        self.addSubview(lblLocationDayWeatherTitle)
        
        lblLocationDayWeatherDetails.accessibilityIdentifier="lblLocationDayWeatherDetails"
        lblLocationDayWeatherDetails.text = "Allow What Sticks (WS) to collect your location to provide weather and timezone calculations for impacts on sleep and exercise. \n\nTurning this on will allow WS to collect your location daily."
        lblLocationDayWeatherDetails.translatesAutoresizingMaskIntoConstraints=false
        lblLocationDayWeatherDetails.numberOfLines = 0
        self.addSubview(lblLocationDayWeatherDetails)
        
        stckVwLocTrackReoccurring.accessibilityIdentifier="stckVwLocationDayWeather"
        stckVwLocTrackReoccurring.translatesAutoresizingMaskIntoConstraints=false
        stckVwLocTrackReoccurring.spacing = 5
        stckVwLocTrackReoccurring.axis = .horizontal
        self.addSubview(stckVwLocTrackReoccurring)
        
        lblLocTrackReoccurringSwitch.accessibilityIdentifier="lblLocationDayWeatherSwitch"
        lblLocTrackReoccurringSwitch.translatesAutoresizingMaskIntoConstraints=false
        stckVwLocTrackReoccurring.addArrangedSubview(lblLocTrackReoccurringSwitch)
        
        swtchLocTrackReoccurring.accessibilityIdentifier = "swtchLocationDayWeather"
        swtchLocTrackReoccurring.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        stckVwLocTrackReoccurring.addArrangedSubview(swtchLocTrackReoccurring)
        setLocationSwitchLabelText()
        
        NSLayoutConstraint.activate([
            lblLocationDayWeatherTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 3)),
            lblLocationDayWeatherTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lblLocationDayWeatherTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            
            lblLocationDayWeatherDetails.topAnchor.constraint(equalTo: lblLocationDayWeatherTitle.bottomAnchor, constant: heightFromPct(percent: 2)),
            lblLocationDayWeatherDetails.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lblLocationDayWeatherDetails.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 3)),
            
            stckVwLocTrackReoccurring.topAnchor.constraint(equalTo: lblLocationDayWeatherDetails.bottomAnchor, constant: heightFromPct(percent: 2)),
            stckVwLocTrackReoccurring.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: widthFromPct(percent: -2)),
            stckVwLocTrackReoccurring.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: heightFromPct(percent: -2))
        ])
    }

    private func manageLocationCollection(){
        print("- accessed manageLocationCollection")
        if locationFetcher.userLocationManagerAuthStatus == "Authorized Always"{
            print("locationFetcher Fetch location")
        }
        else if locationFetcher.userLocationManagerAuthStatus == "Authorized When In Use" {
            print("- do something else 01")
        }
        
        else {
            self.delegate?.removeSpinner()
            self.swtchLocTrackReoccurring.isOn=false
            // Set Location Label
            self.setLocationSwitchLabelText()
            self.delegate?.templateAlert(alertTitle: "", alertMessage: "For better calculations go to Setting and set Location permissions to Always", backScreen: false)
        }
        
    }
    func setLocationSwitchLabelText(){
        print("- in setLocationSwitchLabelText")       
        
        guard let location_permission_device = userStore.user.location_permission_device,
              let location_permission_ws = userStore.user.location_permission_ws
        else {
            print("* No userStore.user.location_permission_device")
            return
        }

        print("--- location_permission_device: \(location_permission_device)")
        print("--- location_permission_ws: \(location_permission_ws)")


        swtchLocTrackReoccurring.isOn = location_permission_ws
        if swtchLocTrackReoccurring.isOn{
            if locationFetcher.userLocationManagerAuthStatus == "Authorized Always"{
                lblLocTrackReoccurringSwitch.text = "Track Location (Once Daily): "
                self.locationFetcher.startMonitoringLocationChanges()
            }
            else if let unwp_last_date = userStore.user.last_location_date,
                    let unwp_timezone = userStore.user.timezone {
                if unwp_timezone != "Etc/GMT"{
                    lblLocTrackReoccurringSwitch.text = "Track Location (\(unwp_last_date)): "
                } else {
                    lblLocTrackReoccurringSwitch.text = "Track Location (Restricted): "
                }
            } else {
                lblLocTrackReoccurringSwitch.text = "Track Location (Restricted): "
            }
        } else {
            lblLocTrackReoccurringSwitch.text = "Track Location (off): "
            locationFetcher.stopMonitoringLocationChanges()
        }
    }
    
    private func sendUpdateDictToApi(updateDict:[String:String]){

        print("- sendUpdateDictToApi: ")
    }
    
    private func switchErrorSwitchBack(){
        if self.swtchLocTrackReoccurring.isOn==true{
            self.swtchLocTrackReoccurring.isOn=false
        } else {
            self.swtchLocTrackReoccurring.isOn=true
        }
        self.setLocationSwitchLabelText()
    }
    
    
    /* Objc Methods*/
    @objc private func switchValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            self.delegate?.showSpinner()
            manageLocationCollection()
            print("UserVcLocationDayWeather switch is ON")
        } else {
            // Are you sure alert; if yes, then sends notification to WSAPI
            alertTurnOffLocationTrackingConfirmation()
            print("UserVcLocationDayWeather switch is OFF")
        }
    }
    
    // Used for delete user
    @objc func alertTurnOffLocationTrackingConfirmation() {
        let alertController = UIAlertController(title: "Are you sure?", message: "Turning off location tracking will reduce accuracy.", preferredStyle: .alert)
        // 'Yes' action
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            // Handle the 'Yes' action here
            self?.delegate?.showSpinner()
            self?.locationFetcher.stopMonitoringLocationChanges()
            
            // Send API permission to track off
            var updateDict = ["location_permission_device":"False","location_permission_ws":"False"]
            if self!.locationFetcher.userLocationManagerAuthStatus == "Authorized Always" || self!.locationFetcher.userLocationManagerAuthStatus == "Authorized When In Use" ||  self!.locationFetcher.userLocationManagerAuthStatus == "Restricted"{
                updateDict["location_permission_device"]="True"
            }
            // in case we need it here is a sampel of user_locations
            // user locations: [["20240708-1325", "37.785834", "-122.406417"], ["20240709-1345", "37.785834", "-122.406417"]]
            print("CAll update User send location")
        }
        // 'No' action
        let noAction = UIAlertAction(title: "No", style: .cancel) {[weak self] _ in
            self?.swtchLocTrackReoccurring.isOn=true
            self?.setLocationSwitchLabelText()
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
//        present(alertController, animated: true, completion: nil)
        self.delegate?.presentAlertController(alertController)
    }
    
}

protocol UserVcLocationDayWeatherDelegate: AnyObject {
    //    func didUpdateWeatherInfo(_ weatherInfo: String)
    func removeSpinner()
    func showSpinner()
    func templateAlert(alertTitle:String,alertMessage: String,  backScreen: Bool)
    func presentAlertController(_ alertController: UIAlertController)
}

class UserVcOffline: UIView {
    
    weak var delegate: UserVcOfflineDelegate?
    
    
    var showLine:Bool!
    let vwOfflineLine = UIView()
    var viewTopAnchor:NSLayoutAnchor<NSLayoutYAxisAnchor>!
    
    let lblOfflineTitle = UILabel()
    let btnConnectDevice = UIButton()
    let lblDescriptionTitle = UILabel()
    let lblDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        self.showLine = false
        setup_UserVcOfflineViews()
    }
    
    init(frame: CGRect, showLine: Bool) {
        self.showLine = showLine
        super.init(frame: frame)
        setup_UserVcOfflineViews_lineOption()
        setup_UserVcOfflineViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_UserVcOfflineViews()
    }
    
    private func setup_UserVcOfflineViews_lineOption(){
        vwOfflineLine.accessibilityIdentifier = "vwOfflineLine"
        vwOfflineLine.translatesAutoresizingMaskIntoConstraints = false
        vwOfflineLine.backgroundColor = UIColor(named: "lineColor")
        self.addSubview(vwOfflineLine)
        NSLayoutConstraint.activate([
            vwOfflineLine.topAnchor.constraint(equalTo: self.topAnchor),
            vwOfflineLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vwOfflineLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vwOfflineLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    
    private func setup_UserVcOfflineViews(){
        lblOfflineTitle.accessibilityIdentifier="lblOfflineTitle"
        lblOfflineTitle.translatesAutoresizingMaskIntoConstraints = false
        lblOfflineTitle.text = "Currently offline"
        lblOfflineTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblOfflineTitle.numberOfLines=0
        self.addSubview(lblOfflineTitle)
        
        btnConnectDevice.accessibilityIdentifier = "btnConnectDevice"
        btnConnectDevice.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnConnectDevice)
        btnConnectDevice.setTitle("Connect device", for: .normal)
        btnConnectDevice.layer.borderColor = UIColor.systemBlue.cgColor
        btnConnectDevice.layer.borderWidth = 2
        btnConnectDevice.backgroundColor = .systemBlue
        btnConnectDevice.layer.cornerRadius = 10
        
        btnConnectDevice.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        btnConnectDevice.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
        
        lblDescriptionTitle.accessibilityIdentifier="lblDescriptionTitle"
        lblDescriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        lblDescriptionTitle.text = "Why do I want to connect device?"
        lblDescriptionTitle.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblDescriptionTitle.numberOfLines=0
        self.addSubview(lblDescriptionTitle)
        
        lblDescription.accessibilityIdentifier="lblDescription"
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        lblDescription.text = "If you would like to see your dashboard you will need to connect your device so your data can be processed."
//        lblDescription.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblDescription.numberOfLines=0
        self.addSubview(lblDescription)
        
        
        if showLine{
            viewTopAnchor = vwOfflineLine.bottomAnchor
        } else {
            viewTopAnchor = self.topAnchor
        }

        
        NSLayoutConstraint.activate([
            lblOfflineTitle.topAnchor.constraint(equalTo: viewTopAnchor, constant: heightFromPct(percent: 3)),
            lblOfflineTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            lblOfflineTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -1)),
            
            btnConnectDevice.topAnchor.constraint(equalTo: lblOfflineTitle.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnConnectDevice.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: widthFromPct(percent: 3)),
            btnConnectDevice.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: widthFromPct(percent: -3)),
            
            
            lblDescriptionTitle.topAnchor.constraint(equalTo: btnConnectDevice.bottomAnchor, constant: heightFromPct(percent: 3)),
            lblDescriptionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: widthFromPct(percent: 2)),
            lblDescriptionTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            lblDescription.topAnchor.constraint(equalTo: lblDescriptionTitle.bottomAnchor, constant: heightFromPct(percent: 2)),
            lblDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: widthFromPct(percent: 3)),
            lblDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: widthFromPct(percent: -1)),
            lblDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: heightFromPct(percent: -5))
            
        ])
        
    }
    
    @objc private func buttonTouchDown(_ sender: UIButton) {
        delegate?.touchDown(sender)
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        
        print("Touch up inside")

    }
    
}

protocol UserVcOfflineDelegate: AnyObject {
    //    func didUpdateWeatherInfo(_ weatherInfo: String)
    func removeSpinner()
    func showSpinner()
    func templateAlert(alertTitle:String,alertMessage: String,  backScreen: Bool)
    func presentAlertController(_ alertController: UIAlertController)
    func touchDown(_ sender: UIButton)
//    func touchDownProxy(_ sender: UIButton)
}

class UserVcUserStatusView: UIView {

    var showLine:Bool!
    let vwUserStatusLine = UIView()
    var viewTopAnchor:NSLayoutAnchor<NSLayoutYAxisAnchor>!

    var userStore: UserStore!
    let lblTitleUserStatus = UILabel()

    let stckVwUser = UIStackView()

    let stckVwUsername = UIStackView()
    let lblUsername = UILabel()
    let btnUsernameFilled = UIButton()
    
    let stckVwRecordCount = UIStackView()
    let lblRecordCount = UILabel()
    let btnRecordCountFilled = UIButton()
    
    var constraints_NO_VwRegisterButton = [NSLayoutConstraint]()
    
    let vwRegisterButton = UserVcRegisterButton()
    var constraints_YES_VwRegisterButton = [NSLayoutConstraint]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showLine = false
        setup_UserVcAccountView()
    }
    init(frame: CGRect, showLine: Bool) {
        self.showLine = showLine
        super.init(frame: frame)
        setup_UserVcAccountView_lineOption()
        setup_UserVcAccountView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_UserVcAccountView()
    }
    private func setup_UserVcAccountView_lineOption(){
        vwUserStatusLine.accessibilityIdentifier = "vwUserStatusLine"
        vwUserStatusLine.translatesAutoresizingMaskIntoConstraints = false
        vwUserStatusLine.backgroundColor = UIColor(named: "lineColor")
        self.addSubview(vwUserStatusLine)
        NSLayoutConstraint.activate([
            vwUserStatusLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            vwUserStatusLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vwUserStatusLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vwUserStatusLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

    private func setup_UserVcAccountView(){
        userStore = UserStore.shared

        lblTitleUserStatus.accessibilityIdentifier="lblTitleUserStatus"
        lblTitleUserStatus.text = "Current account status"
        lblTitleUserStatus.translatesAutoresizingMaskIntoConstraints=false
        lblTitleUserStatus.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblTitleUserStatus.numberOfLines = 0
        self.addSubview(lblTitleUserStatus)

        stckVwUser.accessibilityIdentifier = "stckVwUser"
        stckVwUser.translatesAutoresizingMaskIntoConstraints=false

        stckVwUser.axis = .vertical
        stckVwUser.alignment = .fill
        stckVwUser.distribution = .fillEqually
        stckVwUser.spacing = 10

        stckVwUsername.accessibilityIdentifier = "stckVwUser"
        stckVwUsername.translatesAutoresizingMaskIntoConstraints=false
        stckVwUsername.axis = .horizontal
        stckVwUsername.alignment = .fill
        stckVwUsername.distribution = .fill
        stckVwUsername.spacing = 10

        stckVwRecordCount.accessibilityIdentifier = "stckVwRecordCount"
        stckVwRecordCount.translatesAutoresizingMaskIntoConstraints=false
        stckVwRecordCount.axis = .horizontal
        stckVwRecordCount.alignment = .fill
        stckVwRecordCount.distribution = .fill
        stckVwRecordCount.spacing = 10

        lblUsername.accessibilityIdentifier="lblUsername"
        lblUsername.text = "username"
        lblUsername.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblUsername.translatesAutoresizingMaskIntoConstraints=false
        lblUsername.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        /* there is also setContentCompressionResistancePriority */

        btnUsernameFilled.accessibilityIdentifier="btnUsernameFilled"
        btnUsernameFilled.setTitle(userStore.user.username, for: .normal)
        if let font = UIFont(name: "ArialRoundedMTBold", size: 17) {
            btnUsernameFilled.titleLabel?.font = font
        }
        btnUsernameFilled.backgroundColor = UIColor(named: "ColorRow3Textfields")
        btnUsernameFilled.setTitleColor(UIColor(named: "lineColor"), for: .normal)
        btnUsernameFilled.layer.borderWidth = 1
        btnUsernameFilled.layer.cornerRadius = 5
        btnUsernameFilled.translatesAutoresizingMaskIntoConstraints = false
        btnUsernameFilled.accessibilityIdentifier="btnUsernameFilled"

        stckVwUsername.addArrangedSubview(lblUsername)
        stckVwUsername.addArrangedSubview(btnUsernameFilled)

        stckVwRecordCount.accessibilityIdentifier = "stckVwUser"
        stckVwRecordCount.translatesAutoresizingMaskIntoConstraints=false

        lblRecordCount.accessibilityIdentifier="lblRecordCount"
        lblRecordCount.text = "record count"
        lblRecordCount.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblRecordCount.translatesAutoresizingMaskIntoConstraints=false
        lblRecordCount.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)

        btnRecordCountFilled.accessibilityIdentifier="btnRecordCountFilled"
        btnRecordCountFilled.setTitle("0", for: .normal)
        if let font = UIFont(name: "ArialRoundedMTBold", size: 17) {
            btnRecordCountFilled.titleLabel?.font = font
        }
        btnRecordCountFilled.setTitleColor(UIColor(named: "lineColor"), for: .normal)
        btnRecordCountFilled.backgroundColor = UIColor(named: "ColorRow3Textfields")
        btnRecordCountFilled.layer.borderWidth = 1
        btnRecordCountFilled.layer.cornerRadius = 5
        btnRecordCountFilled.translatesAutoresizingMaskIntoConstraints = false
        btnRecordCountFilled.accessibilityIdentifier="btnRecordCountFilled"

        stckVwRecordCount.addArrangedSubview(lblRecordCount)
        stckVwRecordCount.addArrangedSubview(btnRecordCountFilled)

        stckVwUser.addArrangedSubview(stckVwUsername)
        stckVwUser.addArrangedSubview(stckVwRecordCount)

        self.addSubview(stckVwUser)

        if showLine{
            viewTopAnchor = vwUserStatusLine.bottomAnchor
        } else {
            viewTopAnchor = self.topAnchor
        }
        
        NSLayoutConstraint.activate([
            lblTitleUserStatus.topAnchor.constraint(equalTo: viewTopAnchor, constant: heightFromPct(percent: 3)),
            lblTitleUserStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: 2)),
            lblTitleUserStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),

            stckVwUser.topAnchor.constraint(equalTo: lblTitleUserStatus.bottomAnchor,constant: heightFromPct(percent: 2)),
            stckVwUser.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -1)),
            stckVwUser.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 3)),

            btnUsernameFilled.widthAnchor.constraint(lessThanOrEqualTo: btnRecordCountFilled.widthAnchor)
            ])
        
        
        constraints_NO_VwRegisterButton = [
            stckVwUser.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: heightFromPct(percent: -3)),
        ]
        constraints_YES_VwRegisterButton = [
            vwRegisterButton.topAnchor.constraint(equalTo: stckVwUser.bottomAnchor, constant: heightFromPct(percent: 2)),
            vwRegisterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            vwRegisterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            vwRegisterButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: heightFromPct(percent: -3)),
        ]
        
        if userStore.user.email != nil {
            vwRegisterButton.removeFromSuperview()
            NSLayoutConstraint.activate(constraints_NO_VwRegisterButton)
        } else {
            setup_vcRegistrationButton()
        }
        
    }
    
    func setup_vcRegistrationButton(){
        vwRegisterButton.accessibilityIdentifier = "vwRegisterButton"
        vwRegisterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.deactivate(constraints_NO_VwRegisterButton)
        self.addSubview(vwRegisterButton)
        btnUsernameFilled.setTitle(userStore.user.username, for: .normal)
        NSLayoutConstraint.activate(constraints_YES_VwRegisterButton)
    }
    
    func remove_vcRegistrationButton(){
        NSLayoutConstraint.deactivate(constraints_YES_VwRegisterButton)
        vwRegisterButton.removeFromSuperview()
        btnUsernameFilled.setTitle(userStore.user.username, for: .normal)
        NSLayoutConstraint.activate(constraints_NO_VwRegisterButton)
    }
    
    
    

}

class UserVcRegisterButton: UIView {

    weak var delegate: UserVcRegisterButtonDelegate?
    
    let lblWhyUsernameTitle = UILabel()
    let lblWhyUsernameDescription = UILabel()
    
    let btnRegister = UIButton()
    
    let lblWhyRegisterTitle = UILabel()
    let lblWhyRegisterDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        setup_UserVcRegisterButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_UserVcRegisterButton()
    }
    
    
    private func setup_UserVcRegisterButtonViewDisclaimer(){
        lblWhyUsernameTitle.accessibilityIdentifier="lblWhyUsernameTitle"
        lblWhyUsernameTitle.translatesAutoresizingMaskIntoConstraints = false
        lblWhyUsernameTitle.text = "Why do I have a username?"
        lblWhyUsernameTitle.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblWhyUsernameTitle.numberOfLines=0
        self.addSubview(lblWhyUsernameTitle)
        
        lblWhyUsernameDescription.accessibilityIdentifier="lblWhyUsernameDescription"
        lblWhyUsernameDescription.translatesAutoresizingMaskIntoConstraints = false
        lblWhyUsernameDescription.text = "This ID is used to keep track of the analyzed data. It does not have any personal information."
        lblWhyUsernameDescription.numberOfLines=0
        self.addSubview(lblWhyUsernameDescription)
        NSLayoutConstraint.activate([
            lblWhyUsernameTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 3)),
            lblWhyUsernameTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblWhyUsernameTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            lblWhyUsernameDescription.topAnchor.constraint(equalTo: lblWhyUsernameTitle.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblWhyUsernameDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblWhyUsernameDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            ])
    }
    
    private func setup_UserVcRegisterButton(){
        
        btnRegister.setTitle("Register", for: .normal)
        btnRegister.setImage(UIImage(systemName: "person"), for: .normal)
        btnRegister.tintColor = .white
        btnRegister.layer.borderColor = UIColor.systemBlue.cgColor
        btnRegister.layer.borderWidth = 2
        btnRegister.backgroundColor = .systemBlue
        btnRegister.layer.cornerRadius = 10
        btnRegister.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnRegister)
        // Add space between the image and the text
        btnRegister.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        // Change size of image
        btnRegister.imageView?.layer.transform = CATransform3DMakeScale(1.5,1.5,1.5)
        btnRegister.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 27)

        btnRegister.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        btnRegister.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
        
        lblWhyRegisterTitle.accessibilityIdentifier="lblWhyRegisterTitle"
        lblWhyRegisterTitle.translatesAutoresizingMaskIntoConstraints = false
        lblWhyRegisterTitle.text = "Why Register?"
        lblWhyRegisterTitle.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblWhyRegisterTitle.numberOfLines=0
        self.addSubview(lblWhyRegisterTitle)
        
        lblWhyRegisterDescription.accessibilityIdentifier="lblWhyRegisterDescription"
        lblWhyRegisterDescription.translatesAutoresizingMaskIntoConstraints = false
        lblWhyRegisterDescription.text = "Creating an account will allow you to access your user page on the what-sticks.com website where you can download files with the daily values for each variable used to calculate your correlations."
        lblWhyRegisterDescription.numberOfLines=0
        self.addSubview(lblWhyRegisterDescription)
        
        NSLayoutConstraint.activate([

            btnRegister.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 3)),
            btnRegister.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: widthFromPct(percent: 3)),
            btnRegister.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -3)),
            
            lblWhyRegisterTitle.topAnchor.constraint(equalTo: btnRegister.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblWhyRegisterTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblWhyRegisterTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            lblWhyRegisterDescription.topAnchor.constraint(equalTo: lblWhyRegisterTitle.bottomAnchor, constant: heightFromPct(percent: 3)),
            lblWhyRegisterDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: widthFromPct(percent: 3)),
            lblWhyRegisterDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: widthFromPct(percent: -1)),
            lblWhyRegisterDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: heightFromPct(percent: -5))
            
        ])
        
    }
    
    @objc private func buttonTouchDown(_ sender: UIButton) {
        delegate?.touchDown(sender)
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        
        print("Touch up inside --> vwRegisterButton")

        let regModalVC = RegModalVC()

        // Set the modal presentation style
        regModalVC.modalPresentationStyle = .overCurrentContext
        regModalVC.modalTransitionStyle = .crossDissolve
//        rinconOptionsInviteVC.rincon = self.rincon
//        rinconOptionsInviteVC.rinconStore = self.rinconStore

        // Present the RinconOptionsVC
//        self.present(regModalVC, animated: true, completion: nil)
        self.delegate?.presentNewView(regModalVC)
        
        
    }
    
}

protocol UserVcRegisterButtonDelegate: AnyObject {
    //    func didUpdateWeatherInfo(_ weatherInfo: String)
    func removeSpinner()
    func showSpinner()
    func templateAlert(alertTitle:String,alertMessage: String,  backScreen: Bool)
    func presentAlertController(_ alertController: UIAlertController)
    func touchDown(_ sender: UIButton)
//    func touchDownProxy(_ sender: UIButton)
    func presentNewView(_ uiViewController: UIViewController)
}

class UserVcDelete: UIView {

    weak var delegate: UserVcDeleteDelegate?
    var showLine:Bool!
    let vwDeleteLine = UIView()
    var viewTopAnchor:NSLayoutAnchor<NSLayoutYAxisAnchor>!
    let lblDeleteTitle = UILabel()
    let lblDeleteDescription = UILabel()
    let btnDelete = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showLine=false
        setup_UserVcRegisterButtonViewDisclaimer()
        setup_UserVcRegisterButton()
    }
    
    init(frame: CGRect, showLine: Bool) {
        self.showLine = showLine
        super.init(frame: frame)
        setup_UserVcRegisterButtonViewDisclaimer_with_vwDeleteLine()
        setup_UserVcRegisterButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup_UserVcRegisterButtonViewDisclaimer_with_vwDeleteLine(){
        vwDeleteLine.accessibilityIdentifier = "vwDeleteLine"
        vwDeleteLine.translatesAutoresizingMaskIntoConstraints = false
        vwDeleteLine.backgroundColor = UIColor(named: "lineColor")
        self.addSubview(vwDeleteLine)
        NSLayoutConstraint.activate([
            vwDeleteLine.topAnchor.constraint(equalTo: self.topAnchor, constant:heightFromPct(percent: 1)),
            vwDeleteLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vwDeleteLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vwDeleteLine.heightAnchor.constraint(equalToConstant: 1),
        ])

        lblDeleteTitle.accessibilityIdentifier="lblDeleteTitle"
        lblDeleteTitle.translatesAutoresizingMaskIntoConstraints = false
        lblDeleteTitle.text = "Delete Account"
        lblDeleteTitle.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblDeleteTitle.numberOfLines=0
        self.addSubview(lblDeleteTitle)
        
        lblDeleteDescription.accessibilityIdentifier="lblDeleteDescription"
        lblDeleteDescription.translatesAutoresizingMaskIntoConstraints = false
        lblDeleteDescription.text = "This will delete your credentials and the data you have linked from your phone."
        lblDeleteDescription.numberOfLines=0
        self.addSubview(lblDeleteDescription)
        
        if showLine{
            viewTopAnchor=vwDeleteLine.bottomAnchor
        } else{
            viewTopAnchor=self.topAnchor
        }
        
        NSLayoutConstraint.activate([
            lblDeleteTitle.topAnchor.constraint(equalTo: viewTopAnchor, constant: heightFromPct(percent: 3)),
            lblDeleteTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: widthFromPct(percent: 2)),
            lblDeleteTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            lblDeleteDescription.topAnchor.constraint(equalTo: lblDeleteTitle.bottomAnchor, constant: heightFromPct(percent: 3)),
            lblDeleteDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: widthFromPct(percent: 3)),
            lblDeleteDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
    }
    
    private func setup_UserVcRegisterButtonViewDisclaimer(){
        lblDeleteTitle.accessibilityIdentifier="lblDeleteTitle"
        lblDeleteTitle.translatesAutoresizingMaskIntoConstraints = false
        lblDeleteTitle.text = "Delete Account"
        lblDeleteTitle.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblDeleteTitle.numberOfLines=0
        self.addSubview(lblDeleteTitle)
        
        lblDeleteDescription.accessibilityIdentifier="lblDeleteDescription"
        lblDeleteDescription.translatesAutoresizingMaskIntoConstraints = false
        lblDeleteDescription.text = "This will delete your credentials and the data you have linked from your phone."
        lblDeleteDescription.numberOfLines=0
        self.addSubview(lblDeleteDescription)
        
        NSLayoutConstraint.activate([
            lblDeleteTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 5)),
            lblDeleteTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblDeleteTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            lblDeleteDescription.topAnchor.constraint(equalTo: lblDeleteTitle.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblDeleteDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblDeleteDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            ])
    }
    
    private func setup_UserVcRegisterButton(){

        btnDelete.accessibilityIdentifier = "btnDelete"
        btnDelete.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnDelete)
        btnDelete.setTitle("Delete", for: .normal)
        btnDelete.layer.borderColor = UIColor.systemRed.cgColor
        btnDelete.layer.borderWidth = 2
        btnDelete.backgroundColor = .systemRed
        btnDelete.layer.cornerRadius = 10
        
        btnDelete.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        btnDelete.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
        

        
        NSLayoutConstraint.activate([

            btnDelete.topAnchor.constraint(equalTo: lblDeleteDescription.bottomAnchor, constant: heightFromPct(percent: 5)),
            btnDelete.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: widthFromPct(percent: 3)),
            btnDelete.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: widthFromPct(percent: -3)),
            btnDelete.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: heightFromPct(percent: -5))
            
        ])
        
    }
    
    @objc private func buttonTouchDown(_ sender: UIButton) {
        delegate?.touchDown(sender)
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        
        print("Touch up inside --> vwRegisterButton")

        let regModalVC = RegModalVC()

        // Set the modal presentation style
        regModalVC.modalPresentationStyle = .overCurrentContext
        regModalVC.modalTransitionStyle = .crossDissolve
//        rinconOptionsInviteVC.rincon = self.rincon
//        rinconOptionsInviteVC.rinconStore = self.rinconStore

        // Present the RinconOptionsVC
//        self.present(regModalVC, animated: true, completion: nil)
        self.delegate?.presentNewView(regModalVC)
        
        
    }
    
}

protocol UserVcDeleteDelegate: AnyObject {
    //    func didUpdateWeatherInfo(_ weatherInfo: String)
    func removeSpinner()
    func showSpinner()
    func templateAlert(alertTitle:String,alertMessage: String,  backScreen: Bool)
    func presentAlertController(_ alertController: UIAlertController)
    func touchDown(_ sender: UIButton)
//    func touchDownProxy(_ sender: UIButton)
    func presentNewView(_ uiViewController: UIViewController)
}

