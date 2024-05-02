//
//  NotificationSettingsView.swift
//  Pokket
//
//  Created by Fredy Camas on 4/27/24.
//
import SwiftUI
import UserNotifications

// Mock data model for budget categories
struct BudgetCategoryMock {
    let name: String
    var limit: Double
    var actualSpending: Double
}

// Notification preference model
struct NotificationPreference {
    var isEnabled: Bool
    var frequency: NotificationFrequency
}

enum NotificationFrequency: String, CaseIterable {
    case daily
    case weekly
    case monthly
}

// Main ViewModel
class BudgetTrackerViewModel: ObservableObject {
    @Published var categories: [BudgetCategoryMock]
    @Published var notificationPreferences: NotificationPreference
    
    init() {
        self.categories = [
            BudgetCategoryMock(name: "Groceries", limit: 1000, actualSpending: 500),
            BudgetCategoryMock(name: "Shopping", limit: 2000, actualSpending: 1500),
            BudgetCategoryMock(name: "Entertainment", limit: 2000, actualSpending: 1500),
        ]
        
        let savedFrequency = UserDefaults.standard.string(forKey: "NotificationFrequency") ?? NotificationFrequency.daily.rawValue
        let savedEnabled = UserDefaults.standard.bool(forKey: "NotificationsEnabled")
        self.notificationPreferences = NotificationPreference(isEnabled: savedEnabled, frequency: NotificationFrequency(rawValue: savedFrequency) ?? .daily)
        
        if self.notificationPreferences.isEnabled {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                DispatchQueue.main.async {
                    UserDefaults.standard.set(granted, forKey: "NotificationsEnabled")
                    if granted {
                        self.scheduleNotification()
                    }
                }
            }
        }
        
        // Check budget exceedance when the app launches
        checkBudgetExceedance()
    }
    
    func saveNotificationPreferences() {
        UserDefaults.standard.set(notificationPreferences.isEnabled, forKey: "NotificationsEnabled")
        UserDefaults.standard.set(notificationPreferences.frequency.rawValue, forKey: "NotificationFrequency")
        
        if notificationPreferences.isEnabled {
            DispatchQueue.main.async {
                self.scheduleNotification()
            }
        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    func scheduleNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Budget Notifications Enabled"
        content.body = "You have enabled budget notifications."
        content.sound = UNNotificationSound.default
        
        var timeInterval: TimeInterval = 0
        
        switch notificationPreferences.frequency {
        case .daily:
            timeInterval = 24 * 60 * 60
        case .weekly:
            timeInterval = 7 * 24 * 60 * 60
        case .monthly:
            timeInterval = 30 * 24 * 60 * 60
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
        let request = UNNotificationRequest(identifier: "budgetNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func checkBudgetExceedance() {
        for category in categories {
            if category.actualSpending > category.limit {
                sendExceedanceNotification(for: category)
            }
        }
    }
    
    func sendExceedanceNotification(for category: BudgetCategoryMock) {
        let content = UNMutableNotificationContent()
        content.title = "Budget Exceedance"
        content.body = "You have exceeded the budget limit for \(category.name)."
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: "budgetExceedanceNotification", content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling exceedance notification: \(error.localizedDescription)")
            }
        }
    }
}

// Main View
struct NotificationSettingsView: View {
    @StateObject var viewModel = BudgetTrackerViewModel()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Budget Categories")) {
                    ForEach(viewModel.categories.indices, id: \.self) { index in
                        BudgetCategoryRow(category: $viewModel.categories[index])
                    }
                }
                
                Section(header: Text("Notification Preferences")) {
                    Picker("Notification Frequency", selection: $viewModel.notificationPreferences.frequency) {
                        ForEach(NotificationFrequency.allCases, id: \.self) { frequency in
                            Text(frequency.rawValue.capitalized)
                        }
                    }
                    
                    Toggle(isOn: $viewModel.notificationPreferences.isEnabled) {
                        Text("Enable Notifications")
                    }
                    .onChange(of: viewModel.notificationPreferences.isEnabled) { _ in
                        requestNotificationPermission()
                    }
                }
            }
            .navigationTitle("Notification Settings ")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.saveNotificationPreferences()
                    }
                }
            }
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
                // Handle the case where permission is granted
                viewModel.saveNotificationPreferences()
            } else if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
                // Handle the case where an error occurred
            } else {
                print("Notification permission denied")
                // Handle the case where permission is denied
            }
        }
    }
}

// Custom row view for each budget category
struct BudgetCategoryRow: View {
    @Binding var category: BudgetCategoryMock
    
    var body: some View {
        HStack {
            Text(category.name)
            Spacer()
            TextField("Limit", value: $category.limit, formatter: NumberFormatter.currency)
            TextField("Spending", value: $category.actualSpending, formatter: NumberFormatter.currency)
        }
    }
}

// Number formatter for currency formatting
extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
