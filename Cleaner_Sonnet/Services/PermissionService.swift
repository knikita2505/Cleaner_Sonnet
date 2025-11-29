//
//  PermissionService.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import Foundation
import Combine
import Photos
import Contacts
import UserNotifications
import UIKit

/// Permission service - manages all app permissions (Photos, Contacts, Notifications)
/// Uses real iOS APIs: PhotoKit, Contacts Framework, UserNotifications
class PermissionService: ObservableObject {
    // MARK: - Published Properties
    
    @Published var photoPermissionStatus: PermissionStatus = .notDetermined
    @Published var contactsPermissionStatus: PermissionStatus = .notDetermined
    @Published var notificationsPermissionStatus: PermissionStatus = .notDetermined
    
    // MARK: - Permission Status Enum
    
    enum PermissionStatus {
        case notDetermined
        case granted
        case denied
        case limited // For iOS 14+ limited photo access
    }
    
    // MARK: - Singleton
    
    static let shared = PermissionService()
    
    private init() {
        updatePhotoPermissionStatus()
        updateContactsPermissionStatus()
        updateNotificationsPermissionStatus()
    }
    
    // MARK: - Photo Library Permissions
    
    /// Request photo library access using PhotoKit
    func requestPhotoPermission(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
            DispatchQueue.main.async {
                self?.updatePhotoPermissionStatus()
                let granted = status == .authorized || status == .limited
                completion(granted)
            }
        }
    }
    
    /// Update current photo permission status
    private func updatePhotoPermissionStatus() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch status {
        case .authorized:
            photoPermissionStatus = .granted
        case .limited:
            photoPermissionStatus = .limited
        case .denied, .restricted:
            photoPermissionStatus = .denied
        case .notDetermined:
            photoPermissionStatus = .notDetermined
        @unknown default:
            photoPermissionStatus = .notDetermined
        }
    }
    
    /// Check current photo permission status
    func checkPhotoPermissionStatus() -> PermissionStatus {
        updatePhotoPermissionStatus()
        return photoPermissionStatus
    }
    
    // MARK: - Contacts Permissions
    
    /// Request contacts access using Contacts Framework
    func requestContactsPermission(completion: @escaping (Bool) -> Void) {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { [weak self] granted, error in
            DispatchQueue.main.async {
                self?.updateContactsPermissionStatus()
                completion(granted)
            }
        }
    }
    
    /// Update current contacts permission status
    private func updateContactsPermissionStatus() {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized:
            contactsPermissionStatus = .granted
        case .denied, .restricted:
            contactsPermissionStatus = .denied
        case .notDetermined:
            contactsPermissionStatus = .notDetermined
        @unknown default:
            contactsPermissionStatus = .notDetermined
        }
    }
    
    /// Check current contacts permission status
    func checkContactsPermissionStatus() -> PermissionStatus {
        updateContactsPermissionStatus()
        return contactsPermissionStatus
    }
    
    // MARK: - Notifications Permissions
    
    /// Request notification permission using UserNotifications
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            DispatchQueue.main.async {
                self?.updateNotificationsPermissionStatus()
                completion(granted)
            }
        }
    }
    
    /// Update current notifications permission status
    private func updateNotificationsPermissionStatus() {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { [weak self] settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional, .ephemeral:
                    self?.notificationsPermissionStatus = .granted
                case .denied:
                    self?.notificationsPermissionStatus = .denied
                case .notDetermined:
                    self?.notificationsPermissionStatus = .notDetermined
                @unknown default:
                    self?.notificationsPermissionStatus = .notDetermined
                }
            }
        }
    }
    
    /// Check current notifications permission status
    func checkNotificationsPermissionStatus() -> PermissionStatus {
        // Note: This is async, so we return current cached value
        // Call updateNotificationsPermissionStatus() to refresh
        return notificationsPermissionStatus
    }
    
    // MARK: - Helper Methods
    
    /// Check if all required permissions are granted
    func hasRequiredPermissions() -> Bool {
        return photoPermissionStatus == .granted || photoPermissionStatus == .limited
    }
    
    /// Open app settings for user to manually change permissions
    func openAppSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
    }
}

